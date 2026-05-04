# frozen_string_literal: true

module PlentyClient
  module Rest
    module Pim
      module Variations
        include PlentyClient::Endpoint
        include PlentyClient::Request

        UPDATE_VARIATIONS = '/pim/variations'

        autoload :Properties,  'plenty_client/rest/pim/variations/properties'
        autoload :SalesPrices, 'plenty_client/rest/pim/variations/sales_prices'
        autoload :Markets,     'plenty_client/rest/pim/variations/markets'

        class << self
          def update(body = [])
            put(build_endpoint(UPDATE_VARIATIONS), body)
          end
        end
      end
    end
  end
end