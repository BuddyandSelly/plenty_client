# frozen_string_literal: true

module PlentyClient
  module Accounting
    include PlentyClient::Endpoint
    include PlentyClient::Request

    LIST_VAT_OF_LOCATION    = '/vat/locations/{locationId}'
    LIST_VAT_OF_COUNTRY     = '/vat/locations/{locationId}/countries/{countryId}'
    LIST_VAT_CONFIGURATIONS = '/vat'
    LIST_VAT_STANDARD       = '/vat/standard'

    class << self
      def list(headers = {}, &)
        get(build_endpoint(LIST_VAT_CONFIGURATIONS), headers, &)
      end

      def list_for_country(location_id, country_id, headers = {}, &)
        get(build_endpoint(LIST_VAT_OF_COUNTRY,
                           location: location_id,
                           country: country_id), headers, &)
      end

      def list_for_location(location_id, headers = {}, &)
        get(build_endpoint(LIST_VAT_OF_LOCATION,
                           location: location_id), headers, &)
      end

      def standard(headers = {}, &)
        get(build_endpoint(LIST_VAT_STANDARD), headers, &)
      end
    end
  end
end
