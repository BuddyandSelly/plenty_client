# frozen_string_literal: true

module PlentyClient
  module Account
    module Address
      class ContactRelation
        include PlentyClient::Endpoint
        include PlentyClient::Request

        CONTACT_RELATIONS_BASE_PATH        = '/accounts/addresses/contact_relations'
        SINGLE_CONTACT_RELATION_SUFFIX     = '/{addressContactRelationId}'

        class << self

          def list(headers = {})
            get(CONTACT_RELATIONS_BASE_PATH, headers)
          end

          def find(address_contact_relation_id, headers = {})
            get(url(address_contact_relation_id), headers)
          end

          # def create(headers = {})
          #   post(build_endpoint(ACCOUNT_ADDRESS_BASE_PATH), headers)
          # end
          #
          # def update(address_id, headers = {})
          #   put(url(address_id), headers)
          # end

          def destroy(address_id, headers = {})
            delete(url(address_id), headers)
          end

          private

          def url(address_contact_relation_id)
            build_endpoint(
              CONTACT_RELATIONS_BASE_PATH + SINGLE_CONTACT_RELATION_SUFFIX,
              address_contact_relation: address_contact_relation_id
            )
          end
        end
      end
    end
  end
end
