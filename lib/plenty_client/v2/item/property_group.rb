# frozen_string_literal: true

module PlentyClient
  module V2
    module Item
      class PropertyGroup
        include PlentyClient::Endpoint
        include PlentyClient::Request

        autoload :Name, 'plenty_client/v2/item/property_group/name'

        LIST_PROPERTY_GROUPS   = '/v2/properties/groups'
        GET_PROPERTY_GROUP     = '/v2/properties/groups/{groupId}'
        CREATE_PROPERTY_GROUP  = '/v2/properties/groups'
        UPDATE_PROPERTY_GROUP  = '/v2/properties/groups/{groupId}'
        DELETE_PROPERTY_GROUP  = '/v2/properties/groups/{groupId}'

        class << self
          def list(params = {}, &block)
            get(build_endpoint(LIST_PROPERTY_GROUPS), params, &block)
          end

          def find(group_id, params = {}, &block)
            get(build_endpoint(GET_PROPERTY_GROUP, group: group_id), params, &block)
          end

          def create(body = {})
            post(build_endpoint(CREATE_PROPERTY_GROUP), body)
          end

          def update(group_id, body = {})
            put(build_endpoint(UPDATE_PROPERTY_GROUP, group: group_id), body)
          end

          def destroy(group_id)
            delete(build_endpoint(DELETE_PROPERTY_GROUP, group: group_id))
          end
        end
      end
    end
  end
end
