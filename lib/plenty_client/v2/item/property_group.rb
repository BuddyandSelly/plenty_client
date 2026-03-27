# frozen_string_literal: true

module PlentyClient
  module V2
    module Item
      class PropertyGroup
        include PlentyClient::Endpoint
        include PlentyClient::Request

        LIST_PROPERTY_GROUPS = '/v2/properties/groups'

        class << self
          def list(params = {}, &block)
            get(build_endpoint(LIST_PROPERTY_GROUPS), params, &block)
          end
        end
      end
    end
  end
end
