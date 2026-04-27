# frozen_string_literal: true

module PlentyClient
  module Pim
    class Variation
      include PlentyClient::Endpoint
      include PlentyClient::Request

      UPDATE_VARIATIONS = '/pim/variations'

      class << self
        def update(body = [])
          put(build_endpoint(UPDATE_VARIATIONS), body)
        end
      end
    end
  end
end