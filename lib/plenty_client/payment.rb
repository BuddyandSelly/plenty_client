# frozen_string_literal: true

module PlentyClient
  module Payment
    include PlentyClient::Endpoint
    include PlentyClient::Request

    LIST_PAYMENTS       = '/payments'
    FIND_PAYMENT        = '/payments/{paymentId}'
    CREATE_PAYMENT      = '/payments'
    UPDATE_PAYMENT      = '/payments/{paymentId}'
    PAYMENT_ENTRYDATE   = '/payments/entrydate'
    PAYMENT_IMPORTDATE  = '/payments/importdate'

    class << self
      def list(headers = {}, &)
        get(build_endpoint(LIST_PAYMENT), headers, &)
      end

      def find(payment_id, headers = {}, &)
        get(build_endpoint(FIND_PAYMENT, payment: payment_id), headers, &)
      end

      def update(payment_id, body = {})
        put(build_endpoint(FIND_PAYMENT, payment: payment_id), body)
      end

      def list_by_entry_date(headers = {}, &)
        get(build_endpoint(PAYMENT_ENTRYDATE), headers, &)
      end

      def list_by_import_date(headers = {}, &)
        get(build_endpoint(PAYMENT_IMPORTDATE), headers, &)
      end
    end
  end
end
