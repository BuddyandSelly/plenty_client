# frozen_string_literal: true

module PlentyClient
  module Market
    module Ebay
      class ShopCategory
        include PlentyClient::Endpoint
        include PlentyClient::Request

        LIST_MARKET_EBAY_SHOP_CATEGORIES = '/markets/ebay/shop_categories'

        class << self
          def list(headers = {}, &)
            get(build_endpoint(LIST_MARKET_EBAY_SHOP_CATEGORIES), headers, &)
          end
        end
      end
    end
  end
end
