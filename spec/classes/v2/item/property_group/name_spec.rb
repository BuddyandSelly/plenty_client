require 'spec_helper'

RSpec.describe PlentyClient::V2::Item::PropertyGroup::Name do
  before(:each) do
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
        .with('/v2/properties/groups/names/7', { 'with' => 'group' })
      described_class.find(7, 'with' => 'group')
    end

    it 'calls get with default empty params' do
      expect(described_class).to receive(:get).with('/v2/properties/groups/names/7', {})
      described_class.find(7)
    end
  end

  describe '.create' do
    it 'calls post with the correct endpoint and body' do
      body = { 'groupId' => 1, 'lang' => 'en', 'name' => 'Test Name' }
      expect(described_class).to receive(:post)
        .with('/v2/properties/groups/names', body)
      described_class.create(body)
    end

    it 'calls post with default empty body' do
      expect(described_class).to receive(:post).with('/v2/properties/groups/names', {})
      described_class.create
    end
  end

  describe '.update' do
    it 'calls put with the correct endpoint and body' do
      body = { 'name' => 'Updated Name' }
      expect(described_class).to receive(:put)
        .with('/v2/properties/groups/names/7', body)
      described_class.update(7, body)
    end

    it 'calls put with default empty body' do
      expect(described_class).to receive(:put).with('/v2/properties/groups/names/7', {})
      described_class.update(7)
    end
  end

  describe '.destroy' do
    it 'calls delete with the correct endpoint' do
      expect(described_class).to receive(:delete)
        .with('/v2/properties/groups/names/7')
      described_class.destroy(7)
    end
  end
end
