# frozen_string_literal: true

module PlentyClient
  module Order
    module CouponCode
      class Contact
        include PlentyClient::Endpoint
        include PlentyClient::Request

        LIST_COUPON_CONTACTS = '/orders/coupons/codes/contacts/{contactId}'

        class << self
          def update(contact_id, headers = {}, &)
            post(build_endpoint(LIST_COUPON_CONTACTS, contact: contact_id), headers, &)
          end
        end
      end
    end
  end
end
