# frozen_string_literal: true

module PlentyClient
  module Stock
    include PlentyClient::Endpoint
    include PlentyClient::Request

    LIST_STOCK         = '/stockmanagement/stock'
    LIST_STOCK_BY_TYPE = '/stockmanagement/stock/types/{type}'
    REDISTRIBUTE_STOCK = '/stockmanagement/stock/redistribute'

    class << self
      def list(headers = {}, &)
        get(build_endpoint(LIST_STOCK), headers, &)
      end

      def list_by_type(type_string, headers = {}, &)
        get(build_endpoint(LIST_STOCK_BY_TYPE, type_string: type_string), headers, &)
      end

      def redistribute(body = {})
        put(build_endpoint(REDISTRIBUTE_STOCK), body)
      end
    end
  end
end
