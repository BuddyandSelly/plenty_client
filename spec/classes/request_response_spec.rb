# frozen_string_literal: true

require 'spec_helper'

# How PlentyClient::Request turns a Faraday response into a return value or an
# exception: content types, the error envelopes Plenty sends, and the throttling
# and logging it reads off the response.
RSpec.describe PlentyClient::Request::ClassMethods do
  subject(:client) { Class.new { include PlentyClient::Request } }

  before { configure_client }

  def json_headers
    { 'Content-Type' => 'application/json; charset=UTF-8' }
  end

  def stub_json(body, headers: {})
    stub_request(:get, %r{/rest/things})
      .to_return(status: 200, body: body.is_a?(String) ? body : body.to_json,
                 headers: json_headers.merge(headers))
  end

  describe 'argument checking' do
    it 'rejects an http method it cannot send' do
      expect { client.request(:head, '/things') }
        .to raise_error(ArgumentError, 'unsupported http_method: head')
    end
  end

  describe 'parameters' do
    it 'sends symbol keys as strings' do
      stub_request(:get, %r{/rest/things}).with(query: { 'colour' => 'red', 'page' => '1' })
                                          .to_return(status: 200, body: '{}', headers: json_headers)

      client.get('/things', colour: 'red')

      expect(WebMock).to have_requested(:get, %r{/rest/things}).with(query: { 'colour' => 'red', 'page' => '1' })
    end

    it 'accepts a path without a leading slash' do
      stub_request(:get, 'https://www.example.com/rest/things').to_return(
        status: 200, body: '{}', headers: json_headers
      )

      client.request(:get, 'things')

      expect(WebMock).to have_requested(:get, 'https://www.example.com/rest/things')
    end
  end

  describe 'logging' do
    it 'installs the Faraday logger when Config.log is set' do
      PlentyClient::Config.log = true
      stub_json({})
      log = StringIO.new

      begin
        original = $stdout
        $stdout = log
        client.request(:get, '/things')
      ensure
        $stdout = original
      end

      expect(log.string).to include('request: GET https://www.example.com/rest/things')
    end
  end

  describe 'response content types' do
    it 'parses a JSON body' do
      stub_json({ 'countryId' => 1 })

      expect(client.request(:get, '/things')).to eq('countryId' => 1)
    end

    it 'returns the body of a PDF untouched' do
      stub_request(:get, %r{/rest/things})
        .to_return(status: 200, body: '%PDF-1.4 ...', headers: { 'Content-Type' => 'application/pdf' })

      expect(client.request(:get, '/things')).to eq('%PDF-1.4 ...')
    end

    it 'returns nil for an empty body' do
      stub_request(:get, %r{/rest/things}).to_return(status: 200, body: '   ', headers: json_headers)

      expect(client.request(:get, '/things')).to be_nil
    end

    it 'raises for a body that claims to be JSON but is not' do
      stub_json('<html></html>')

      expect { client.request(:get, '/things') }
        .to raise_error(PlentyClient::ResponseError, 'invalid response')
    end

    it 'raises for a content type it cannot handle' do
      stub_request(:get, %r{/rest/things})
        .to_return(status: 200, body: 'GIF89a', headers: { 'Content-Type' => 'image/gif' })

      expect { client.request(:get, '/things') }
        .to raise_error(PlentyClient::ResponseError, 'unsupported response Content-Type: image/gif')
    end
  end

  describe 'error envelopes' do
    it 'passes a response without an error key through' do
      stub_json({ 'entries' => [{ 'id' => 1 }] })

      expect(client.request(:get, '/things')).to eq('entries' => [{ 'id' => 1 }])
    end

    it 'raises NotFound when the message says there are no results' do
      stub_json({ 'error' => { 'message' => 'No query results for model [Item] 42' } })

      expect { client.request(:get, '/things') }
        .to raise_error(PlentyClient::NotFound, /No query results/)
    end

    it 'raises ResponseError with the message of the error' do
      stub_json({ 'error' => { 'message' => 'Something went wrong' } })

      expect { client.request(:get, '/things') }
        .to raise_error(PlentyClient::ResponseError, 'Something went wrong')
    end

    it 'raises InvalidCredentials when the error names them' do
      stub_json({ 'error' => 'invalid_credentials' })

      expect { client.request(:get, '/things') }.to raise_error(PlentyClient::Config::InvalidCredentials)
    end

    it 'reads the error out of the first element of an array response' do
      stub_json([{ 'error' => { 'message' => 'Something went wrong' } }])

      expect { client.request(:get, '/things') }
        .to raise_error(PlentyClient::ResponseError, 'Something went wrong')
    end

    it 'passes an empty array response through' do
      stub_json([])

      expect(client.request(:get, '/things')).to eq([])
    end
  end

  describe 'validation errors' do
    def expect_message(validation_errors, message)
      stub_json({ 'error' => { 'message' => 'unused' }, 'validation_errors' => validation_errors })

      expect { client.request(:get, '/things') }.to raise_error(PlentyClient::ResponseError, message)
    end

    it 'joins the messages of a hash keyed by field' do
      expect_message({ 'name' => ['is required'], 'sku' => ['is too long'] }, 'is required, is too long')
    end

    it 'joins the messages of an array of fields' do
      expect_message([{ 'name' => ['is required'] }, { 'sku' => ['is too long'] }], 'is required, is too long')
    end

    it 'joins an array of plain messages' do
      expect_message(['is required', 'is too long'], 'is required, is too long')
    end

    it 'takes a single message as it is' do
      expect_message('is required', 'is required')
    end

    it 'falls back to the message of the error when the list is empty' do
      stub_json({ 'error' => { 'message' => 'Something went wrong' }, 'validation_errors' => {} })

      expect { client.request(:get, '/things') }
        .to raise_error(PlentyClient::ResponseError, 'Something went wrong')
    end
  end

  describe 'throttling' do
    it 'ignores empty rate limit headers' do
      stub_json({}, headers: { 'X-Plenty-Global-Short-Period-Calls-Left' => '',
                               'X-Plenty-Global-Short-Period-Decay' => '' })

      client.request(:get, '/things')

      expect(PlentyClient::Config.request_wait_until).to be_nil
    end

    it 'does not wait while there are calls left' do
      stub_json({}, headers: { 'X-Plenty-Global-Short-Period-Calls-Left' => '42',
                               'X-Plenty-Global-Short-Period-Decay' => '5' })

      client.request(:get, '/things')

      expect(PlentyClient::Config.request_wait_until).to be_nil
    end
  end

  describe 'HTTP status codes' do
    { 301 => PlentyClient::RedirectionError,
      404 => PlentyClient::ClientError,
      500 => PlentyClient::ServerError }.each do |status, error|
      it "raises #{error} for #{status}" do
        stub_request(:get, %r{/rest/things}).to_return(status: status, body: 'nope', headers: json_headers)

        expect { client.request(:get, '/things') }
          .to raise_error(error, "Invalid response: HTTP status: #{status}: nope")
      end
    end
  end
end
