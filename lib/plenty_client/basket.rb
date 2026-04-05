# frozen_string_literal: true

module PlentyClient
  module Basket
    include PlentyClient::Endpoint
    include PlentyClient::Request

    FIND_BASKET = '/basket'

    class << self
      def find(headers = {}, &)
        get(build_endpoint(FIND_BASKET), headers, &)
      end
    end
  end
end
