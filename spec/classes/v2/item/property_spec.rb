require 'spec_helper'

RSpec.describe PlentyClient::V2::Item::Property do
  before(:each) do
    PlentyClient::Config.site_url = 'https://www.example.com'
    PlentyClient::Config.api_user = 'example'
    PlentyClient::Config.api_password = 'secret'
    PlentyClient::Config.access_token = 'ACCESS_TOKEN'
    PlentyClient::Config.refresh_token = 'REFRESH_TOKEN'
    PlentyClient::Config.expiry_date = Time.now + 86400
  end

  def response_headers
    { 'Content-Type' => 'application/json; charset=UTF-8' }
  end

  describe '.list' do
    context 'without a block' do
      it 'calls get with the correct endpoint and params' do
        expect(described_class).to receive(:get)
          .with('/v2/properties', { 'with' => 'names', 'itemsPerPage' => 25 })
        described_class.list('with' => 'names', 'itemsPerPage' => 25)
      end

      it 'calls get with default empty params' do
        expect(described_class).to receive(:get).with('/v2/properties', {})
        described_class.list
      end
    end

    context 'with a block' do
      before do
        stub_request(:get, /example\.com\/rest\/v2\/properties/)
          .to_return do |r|
          query = CGI.parse(r.uri.query)
          page = query['page'][0].to_i
          {
            body: {
              page: page,
              totalsCount: 2,
              isLastPage: (page == 2),
              entries: [
                { 'id' => page * 10 + 1, 'cast' => 'string' },
                { 'id' => page * 10 + 2, 'cast' => 'int' }
              ]
            }.to_json,
            headers: response_headers
          }
        end
      end

      it 'paginates through all pages' do
        described_class.list({}) { |_entry| }
        expect(WebMock).to have_requested(:get, /v2\/properties/).times(2)
      end

      it 'yields entries from each page' do
        expect { |b| described_class.list({}, &b) }.to yield_control.exactly(2).times
      end
    end

    context 'with query parameters' do
      it 'forwards params to the API' do
        stub_request(:get, /example\.com\/rest\/v2\/properties/)
          .to_return(
            body: { page: 1, isLastPage: true, entries: [] }.to_json,
            headers: response_headers
          )

        described_class.list('with' => 'names,options', 'orderBy' => 'position', 'itemsPerPage' => 25)

        expect(WebMock).to have_requested(:get, /v2\/properties/)
          .with(query: hash_including('with' => 'names,options', 'orderBy' => 'position', 'itemsPerPage' => '25'))
      end
    end
  end

  describe '.find' do
    it 'calls get with the correct endpoint and params' do
      expect(described_class).to receive(:get)
        .with('/v2/properties/42', { 'with' => 'names' })
      described_class.find(42, 'with' => 'names')
    end

    it 'calls get with default empty params' do
      expect(described_class).to receive(:get).with('/v2/properties/42', {})
      described_class.find(42)
    end
  end

  describe '.create' do
    it 'calls post with the correct endpoint and body' do
      body = { 'cast' => 'string', 'type' => 'item', 'names' => [{ 'lang' => 'en', 'name' => 'Color' }] }
      expect(described_class).to receive(:post)
        .with('/v2/properties', body)
      described_class.create(body)
    end

    it 'calls post with default empty body' do
      expect(described_class).to receive(:post).with('/v2/properties', {})
      described_class.create
    end
  end

  describe '.update' do
    it 'calls put with the correct endpoint and body' do
      body = { 'cast' => 'int', 'names' => [{ 'lang' => 'en', 'name' => 'Weight' }] }
      expect(described_class).to receive(:put)
        .with('/v2/properties/42', body)
      described_class.update(42, body)
    end

    it 'calls put with default empty body' do
      expect(described_class).to receive(:put).with('/v2/properties/42', {})
      described_class.update(42)
    end
  end

  describe '.destroy' do
    it 'calls delete with the correct endpoint' do
      expect(described_class).to receive(:delete)
        .with('/v2/properties/42')
      described_class.destroy(42)
    end
  end
end
