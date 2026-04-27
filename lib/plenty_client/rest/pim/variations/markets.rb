# frozen_string_literal: true

module PlentyClient
  module Rest
    module Pim
      module Variations
        class Markets
          include PlentyClient::Endpoint
          include PlentyClient::Request

          DELETE_MARKETS = '/pim/variations/markets'

          class << self
            def delete(body = [])
              request(:delete, build_endpoint(DELETE_MARKETS), body)
            end
          end
        end
      end
    end
  end
end