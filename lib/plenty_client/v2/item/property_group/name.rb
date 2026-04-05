# frozen_string_literal: true

module PlentyClient
  module V2
    module Item
      class PropertyGroup
        class Name
          include PlentyClient::Endpoint
          include PlentyClient::Request

          CREATE_PROPERTY_GROUP_NAME = '/v2/properties/groups/names'
          GET_PROPERTY_GROUP_NAME    = '/v2/properties/groups/names/{nameId}'
          UPDATE_PROPERTY_GROUP_NAME = '/v2/properties/groups/names/{nameId}'
          DELETE_PROPERTY_GROUP_NAME = '/v2/properties/groups/names/{nameId}'

          class << self
            def find(name_id, params = {}, &)
              get(build_endpoint(GET_PROPERTY_GROUP_NAME, name: name_id), params, &)
            end

            def create(body = {})
              post(build_endpoint(CREATE_PROPERTY_GROUP_NAME), body)
            end

            def update(name_id, body = {})
              put(build_endpoint(UPDATE_PROPERTY_GROUP_NAME, name: name_id), body)
            end

            def destroy(name_id)
              delete(build_endpoint(DELETE_PROPERTY_GROUP_NAME, name: name_id))
            end
          end
        end
      end
    end
  end
end
