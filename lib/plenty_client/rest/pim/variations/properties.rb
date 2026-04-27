# frozen_string_literal: true

module PlentyClient
  module Rest
    module Pim
      module Variations
        class Properties
          include PlentyClient::Endpoint
          include PlentyClient::Request

          DELETE_PROPERTIES = '/pim/variations/properties'

          class << self
            def delete(body = [])
              request(:delete, build_endpoint(DELETE_PROPERTIES), body)
            end
          end
        end
      end
    end
  end
end