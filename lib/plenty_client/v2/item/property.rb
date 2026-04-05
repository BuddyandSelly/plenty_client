# frozen_string_literal: true

module PlentyClient
  module V2
    module Item
      class Property
        include PlentyClient::Endpoint
        include PlentyClient::Request

        autoload :Name, 'plenty_client/v2/item/property/name'

        LIST_PROPERTIES   = '/v2/properties'
        GET_PROPERTY      = '/v2/properties/{propertyId}'
        CREATE_PROPERTY   = '/v2/properties'
        UPDATE_PROPERTY   = '/v2/properties/{propertyId}'
        DELETE_PROPERTY   = '/v2/properties/{propertyId}'

        class << self
          def list(params = {}, &)
            get(build_endpoint(LIST_PROPERTIES), params, &)
          end

          def find(property_id, params = {}, &)
            get(build_endpoint(GET_PROPERTY, property: property_id), params, &)
          end

          def create(body = {})
            post(build_endpoint(CREATE_PROPERTY), body)
          end

          def update(property_id, body = {})
            put(build_endpoint(UPDATE_PROPERTY, property: property_id), body)
          end

          def destroy(property_id)
            delete(build_endpoint(DELETE_PROPERTY, property: property_id))
          end
        end
      end
    end
  end
end
