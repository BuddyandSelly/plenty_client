require 'spec_helper'

RSpec.describe PlentyClient::Rest::Pim::Variations::Markets do
  before(:each) do
    PlentyClient::Config.site_url = 'https://www.example.com'
    PlentyClient::Config.api_user = 'example'
    PlentyClient::Config.api_password = 'secret'
    PlentyClient::Config.access_token = 'ACCESS_TOKEN'
    PlentyClient::Config.refresh_token = 'REFRESH_TOKEN'
    PlentyClient::Config.expiry_date = Time.now + 86400
  end

  describe '.delete' do
    it 'calls request with :delete, the correct endpoint and an array body' do
      body = [{ 'variationId' => 1942909, 'marketId' => 102 }]
      expect(described_class).to receive(:request)
        .with(:delete, '/pim/variations/markets', body)
      described_class.delete(body)
    end

    it 'calls request with default empty array body' do
      expect(described_class).to receive(:request)
        .with(:delete, '/pim/variations/markets', [])
      described_class.delete
    end
  end
end
