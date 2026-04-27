# frozen_string_literal: true

module PlentyClient
  module Rest
    module Pim
      module Variations
        autoload :Properties,  'plenty_client/rest/pim/variations/properties'
        autoload :SalesPrices, 'plenty_client/rest/pim/variations/sales_prices'
        autoload :Markets,     'plenty_client/rest/pim/variations/markets'
      end
    end
  end
end