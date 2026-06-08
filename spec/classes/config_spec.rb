require 'spec_helper'

RSpec.describe PlentyClient::Config do
  let(:config) { PlentyClient::Config }

  describe 'error handling' do
    describe '.validate_credentials' do
      before(:each) do
        config.site_url = 'https://www.example.com'
        config.api_user = 'foobar'
        config.api_password = 'foobar'
      end

      context 'when an attribute is missing' do
        context 'when site_url is nil' do
          it 'raises PlentyClient::Config::NoCredentials' do
            config.site_url = nil
            expect { config.validate_credentials }.to raise_exception(PlentyClient::Config::NoCredentials)
          end
        end

        context 'when api_user is nil' do
          it 'raises PlentyClient::Config::NoCredentials' do
            config.api_user = nil
            expect { config.validate_credentials }.to raise_exception(PlentyClient::Config::NoCredentials)
          end
        end

        context 'when api_password is nil' do
          it 'raises PlentyClient::Config::NoCredentials' do
            config.api_password = nil
            expect { config.validate_credentials }.to raise_exception(PlentyClient::Config::NoCredentials)
          end
        end
      end
    end

    describe '.tokens_valid?' do
      before do
        PlentyClient::Config.access_token = 'foobar_token'
        PlentyClient::Config.refresh_token = 'refresh_token'
        PlentyClient::Config.expiry_date = Time.now + 86400
      end

      context 'when all attributes are present' do
        it 'returns true' do
          expect(config.tokens_valid?).to be true
        end
      end

      context 'when access_token is nil' do
        it 'returns false' do
          config.access_token = nil
          expect(config.tokens_valid?).to be false
        end
      end

      context 'when refresh_token is nil' do
        it 'returns false' do
          config.refresh_token = nil
          expect(config.tokens_valid?).to be false
        end
      end

      context 'when expiry_date is nil' do
        it 'returns false' do
          config.expiry_date = nil
          expect(config.tokens_valid?).to be false
        end
      end

      context 'when expiry_date is in the past' do
        it 'returns false' do
          config.expiry_date = Time.now - 86400
          expect(config.tokens_valid?).to be false
        end
      end
    end
  end

  describe 'request timeouts' do
    after do
      config.open_timeout = nil
      config.timeout = nil
    end

    describe '.open_timeout' do
      it 'defaults to OPEN_TIMEOUT (5 seconds)' do
        config.open_timeout = nil
        expect(config.open_timeout).to eq(5)
      end

      it 'returns an overridden value' do
        config.open_timeout = 12
        expect(config.open_timeout).to eq(12)
      end
    end

    describe '.timeout' do
      it 'defaults to TIMEOUT (30 seconds)' do
        config.timeout = nil
        expect(config.timeout).to eq(30)
      end

      it 'returns an overridden value' do
        config.timeout = 99
        expect(config.timeout).to eq(99)
      end
    end
  end
end
