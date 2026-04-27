# frozen_string_literal: true

module PlentyClient
  module Rest
    module Pim
      module Variations
        class SalesPrices
          include PlentyClient::Endpoint
          include PlentyClient::Request

          DELETE_SALES_PRICES = '/pim/variations/sales_prices'

          class << self
            def delete(body = [])
              request(:delete, build_endpoint(DELETE_SALES_PRICES), body)
            end
          end
        end
      end
    end
  end
end