require 'spec_helper'

RSpec.describe PlentyClient::Rest::Pim::Variations do
  before(:each) do
    PlentyClient::Config.site_url = 'https://www.example.com'
    PlentyClient::Config.api_user = 'example'
    PlentyClient::Config.api_password = 'secret'
    PlentyClient::Config.access_token = 'ACCESS_TOKEN'
    PlentyClient::Config.refresh_token = 'REFRESH_TOKEN'
    PlentyClient::Config.expiry_date = Time.now + 86400
  end

  describe '.update' do
    it 'calls put with the correct endpoint and an array body' do
      body = [
        {
          'id' => 1942909,
          'properties' => [
            { 'propertyId' => 108, 'groupId' => 5, 'values' => [{ 'lang' => 'en', 'value' => 'Multicolored' }] }
          ]
        }
      ]
      expect(described_class).to receive(:put)
        .with('/pim/variations', body)
      described_class.update(body)
    end

    it 'calls put with default empty array body' do
      expect(described_class).to receive(:put).with('/pim/variations', [])
      described_class.update
    end
  end
end
