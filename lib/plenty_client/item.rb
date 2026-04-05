# frozen_string_literal: true

module PlentyClient
  module Item
    include PlentyClient::Endpoint
    include PlentyClient::Request

    LIST_ITEMS    = '/items'
    CREATE_ITEM   = '/items'
    UPDATE_ITEM   = '/items/{itemId}'
    GET_ITEM      = '/items/{itemId}'
    DELETE_ITEM   = '/items/{itemId}'

    class << self
      def list(headers = {}, &)
        get(build_endpoint(LIST_ITEMS), headers, &)
      end

      def find(item_id = nil, headers = {}, &)
        get(build_endpoint(GET_ITEM, item: item_id), headers, &)
      end

      def update(item_id, body = {})
        put(build_endpoint(UPDATE_ITEM, item: item_id), body)
      end

      def create(body = {})
        post(CREATE_ITEM, body)
      end

      def destroy(item_id, body = {})
        delete(build_endpoint(DELETE_ITEM, item: item_id), body)
      end
    end
  end
end
