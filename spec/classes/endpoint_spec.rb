# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PlentyClient::Endpoint::ClassMethods do
  subject(:endpoint) { Class.new { include PlentyClient::Endpoint } }

  describe '#build_endpoint' do
    it 'replaces the placeholder of every argument it knows' do
      expect(endpoint.build_endpoint('/items/{itemId}/variations/{variationId}', item: 7, variation: 9))
        .to eq('/items/7/variations/9')
    end

    it 'leaves the template alone when there are no arguments' do
      expect(endpoint.build_endpoint('/items')).to eq('/items')
    end

    it 'does not modify the template it is given' do
      template = '/items/{itemId}'
      endpoint.build_endpoint(template, item: 7)

      expect(template).to eq('/items/{itemId}')
    end

    it 'stringifies the values' do
      expect(endpoint.build_endpoint('/items/attribute_values/{attributeValueId}/names/{lang}',
                                     attribute_value: 3, lang: :de))
        .to eq('/items/attribute_values/3/names/de')
    end

    it 'raises for an argument that is not an endpoint parameter' do
      expect { endpoint.build_endpoint('/items/{itemId}', nonsense: 1) }
        .to raise_error(KeyError, 'key not found: :nonsense')
    end

    it 'ignores an argument whose placeholder is not in the template' do
      expect(endpoint.build_endpoint('/items', item: 7)).to eq('/items')
    end
  end

  describe '#routes' do
    it 'prints the route constants of a module' do
      expect { PlentyClient::Account.routes }
        .to output(%r{^LIST_ACCOUNTS: \s+/accounts$}m).to_stdout
    end

    it 'skips constants that are not route names' do
      expect { PlentyClient::Item.routes }.not_to output(/Variation/).to_stdout
    end
  end
end
