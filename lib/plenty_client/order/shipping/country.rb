# frozen_string_literal: true

module PlentyClient
  module Order
    module Shipping
      class Country
        include PlentyClient::Endpoint
        include PlentyClient::Request

        LIST_SHIPPING_COUNTRIES = '/orders/shipping/countries'

        class << self
          def list(headers = {}, &)
            get(build_endpoint(LIST_SHIPPING_COUNTRIES), headers, &)
          end
        end
      end
    end
  end
end
