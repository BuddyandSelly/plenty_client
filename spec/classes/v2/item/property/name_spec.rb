require 'spec_helper'

RSpec.describe PlentyClient::V2::Item::Property::Name do
  before do
    PlentyClient::Config.site_url = 'https://www.example.com'
    PlentyClient::Config.api_user = 'example'
    PlentyClient::Config.api_password = 'secret'
    PlentyClient::Config.access_token = 'ACCESS_TOKEN'
    PlentyClient::Config.refresh_token = 'REFRESH_TOKEN'
    PlentyClient::Config.expiry_date = Time.now + 86400
  end

  describe '.find' do
    it 'calls get with the correct endpoint and params' do
      expect(described_class).to receive(:get)
        .with('/v2/properties/names/7', { 'with' => 'property' })
      described_class.find(7, 'with' => 'property')
    end

    it 'calls get with default empty params' do
      expect(described_class).to receive(:get).with('/v2/properties/names/7', {})
      described_class.find(7)
    end
  end

  describe '.create' do
    it 'calls post with the correct endpoint and body' do
      body = { 'propertyId' => 1, 'lang' => 'en', 'name' => 'Color', 'description' => 'The color' }
      expect(described_class).to receive(:post)
        .with('/v2/properties/names', body)
      described_class.create(body)
    end

    it 'calls post with default empty body' do
      expect(described_class).to receive(:post).with('/v2/properties/names', {})
      described_class.create
    end
  end

  describe '.update' do
    it 'calls put with the correct endpoint and body' do
      body = { 'name' => 'Updated Name', 'description' => 'Updated description' }
      expect(described_class).to receive(:put)
        .with('/v2/properties/names/7', body)
      described_class.update(7, body)
    end

    it 'calls put with default empty body' do
      expect(described_class).to receive(:put).with('/v2/properties/names/7', {})
      described_class.update(7)
    end
  end

  describe '.destroy' do
    it 'calls delete with the correct endpoint' do
      expect(described_class).to receive(:delete)
        .with('/v2/properties/names/7')
      described_class.destroy(7)
    end
  end
end
