# frozen_string_literal: true

# Every endpoint method the gem exposes, with the verb it sends and the path it
# builds. The gem is mostly a table of PlentyMarkets routes, so this is the table
# of what those routes have to come out as - a typo in a route constant or in a
# build_endpoint key cannot pass unnoticed.
#
# A row is [method, arguments, verb, path] and optionally a fifth element for the
# payload, which is the second argument the verb receives:
#
#   omitted  the empty hash the method forwards as headers or as a body
#   :none    the method sends no payload at all
#   []       the bulk endpoints, which take an array of objects
#
# String arguments are the ones the route interpolates as-is (a language, a
# currency, a coupon code); the numbered ones are ids.
module EndpointRoutes
  NO_PAYLOAD = :none

  ALL = {
    'PlentyClient::Account' => [
      [:create, [], :post, '/accounts'],
      [:destroy, [1], :delete, '/accounts/1'],
      [:find, [1], :get, '/accounts/1'],
      [:list, [], :get, '/accounts'],
      [:list_contacts, [1], :get, '/accounts/1/contacts'],
      [:login, [], :post, '/account/login'],
      [:logout, [], :post, '/account/logout'],
      [:refresh_login, [], :post, '/account/login/refresh'],
      [:update, [1], :put, '/accounts/1']
    ],
    'PlentyClient::Account::Address' => [
      [:create, [], :post, '/accounts/addresses'],
      [:destroy, [1], :delete, '/accounts/addresses/1'],
      [:find, [1], :get, '/accounts/addresses/1'],
      [:update, [1], :put, '/accounts/addresses/1']
    ],
    'PlentyClient::Account::Contact' => [
      [:create, [], :post, '/accounts/contacts'],
      [:destroy, [1], :delete, '/accounts/contacts/1'],
      [:find, [1], :get, '/accounts/contacts/1'],
      [:list, [], :get, '/accounts/contacts'],
      [:update, [1], :put, '/accounts/contacts/1']
    ],
    'PlentyClient::Account::Contact::Address' => [
      [:create, [1], :post, '/accounts/contacts/1/addresses'],
      [:destroy, [1, 2], :delete, '/accounts/contacts/1/addresses/2'],
      [:list, [1, 2], :get, '/accounts/contacts/1/addresses/2'],
      [:update, [1, 2], :put, '/accounts/contacts/1/addresses/2'],
      [:update_primary, [1, 2, 3], :put, '/accounts/contacts/1/addresses/2/types/3/primary']
    ],
    'PlentyClient::Account::Contact::Bank' => [
      [:create, [], :post, '/accounts/contacts/banks'],
      [:destroy, [1], :delete, '/accounts/contacts/banks/1'],
      [:find, [1], :get, '/accounts/contacts/banks/1'],
      [:list, [1], :get, '/accounts/contacts/1/banks'],
      [:update, [1], :put, '/accounts/contacts/banks/1']
    ],
    'PlentyClient::Account::Contact::Type' => [
      [:create, [], :post, '/accounts/contacts/types'],
      [:destroy, [1], :delete, '/accounts/contacts/types/1'],
      [:find, [1], :get, '/accounts/contacts/types/1'],
      [:list, [], :get, '/accounts/contacts/types'],
      [:update, [1], :put, '/accounts/contacts/types/1']
    ],
    'PlentyClient::Accounting' => [
      [:list, [], :get, '/vat'],
      [:list_for_country, [1, 2], :get, '/vat/locations/1/countries/2'],
      [:list_for_location, [1], :get, '/vat/locations/1'],
      [:standard, [], :get, '/vat/standard']
    ],
    'PlentyClient::Authentication' => [
      [:access_token, [], :get, '/oauth/access_token'],
      [:client_access_token, [], :post, '/client-login'],
      [:login, [], :post, '/login'],
      [:login_refresh, [], :post, '/login/refresh'],
      [:logout, [], :post, '/logout']
    ],
    'PlentyClient::Authorization' => [
      [:list, [], :get, '/authorized_user'],
      [:list_with_ui_config, [], :get, '/user/authorized_user_with_ui_config']
    ],
    'PlentyClient::Basket' => [
      [:find, [], :get, '/basket']
    ],
    'PlentyClient::Basket::Item' => [
      [:create, [], :post, '/basket/items'],
      [:list, [], :get, '/basket/items']
    ],
    'PlentyClient::Category' => [
      [:create, [], :post, '/categories'],
      [:destroy, [1], :delete, '/categories/1'],
      [:destroy_clients, [1], :delete, '/categories/1/clients'],
      [:destroy_details, [1], :delete, '/categories/1/details'],
      [:find, [1], :get, '/categories/1'],
      [:list, [], :get, '/categories'],
      [:update, [1], :put, '/categories/1'],
      [:update_all, [], :put, '/categories']
    ],
    'PlentyClient::Category::Branch' => [
      [:find, [1], :get, '/category_branches/1'],
      [:list, [], :get, '/category_branches']
    ],
    'PlentyClient::Category::Template' => [
      [:destroy, [1], :delete, '/categories/1/templates'],
      [:list, [1], :get, '/categories/1/templates'],
      [:update, [1], :put, '/categories/1/templates']
    ],
    'PlentyClient::Comment' => [
      [:create, [], :post, '/comments'],
      [:destroy, [1], :delete, '/comments/1'],
      [:find, [1], :get, '/comments/1'],
      [:list, [1, 2], :get, '/comments/1/2']
    ],
    'PlentyClient::Document' => [
      [:download, [1], :get, '/documents/1']
    ],
    'PlentyClient::Document::Category' => [
      [:destroy, [1, 2], :delete, '/categories/1/documents/2'],
      [:download, [1], :get, '/categories/1/documents/downloads'],
      [:list, [1], :get, '/categories/1/documents/'],
      [:upload, [1], :post, '/categories/1/documents']
    ],
    'PlentyClient::Document::Order' => [
      [:download, [1, 2], :get, '/orders/1/documents/downloads/2'],
      [:download_by_type, [1], :get, '/orders/documents/downloads/1'],
      [:list, [1, 2], :get, '/orders/1/documents/2'],
      [:list_by_type, [1], :get, '/orders/documents/1'],
      [:upload, [1, 2], :post, '/orders/1/documents/2']
    ],
    'PlentyClient::Item' => [
      [:create, [], :post, '/items'],
      [:destroy, [1], :delete, '/items/1'],
      [:find, [1], :get, '/items/1'],
      [:list, [], :get, '/items'],
      [:update, [1], :put, '/items/1']
    ],
    'PlentyClient::Item::Attribute' => [
      [:create, [], :post, '/items/attributes'],
      [:destroy, [1], :delete, '/items/attributes/1', NO_PAYLOAD],
      [:find, [1], :get, '/items/attributes/1'],
      [:list, [], :get, '/items/attributes'],
      [:update, [1], :post, '/items/attributes/1']
    ],
    'PlentyClient::Item::Attribute::Name' => [
      [:create, [1], :post, '/items/attributes/1/names'],
      [:destroy, [1, 'en'], :delete, '/items/attributes/1/names/en', NO_PAYLOAD],
      [:find, [1, 'en'], :get, '/items/attributes/1/names/en'],
      [:list, [1], :get, '/items/attributes/1/names'],
      [:update, [1, 'en'], :put, '/items/attributes/1/names/en']
    ],
    'PlentyClient::Item::Attribute::Value' => [
      [:create, [1], :post, '/items/attributes/1/values'],
      [:destroy, [1, 2], :delete, '/items/attributes/1/values/2', NO_PAYLOAD],
      [:find, [1, 2], :get, '/items/attributes/1/values/2'],
      [:list, [1], :get, '/items/attributes/1/values'],
      [:update, [1, 2], :put, '/items/attributes/1/values/2']
    ],
    'PlentyClient::Item::Attribute::ValueName' => [
      [:create, [1], :post, '/items/attribute_values/1/names'],
      [:destroy, [1, 'en'], :delete, '/items/attribute_values/1/names/en', NO_PAYLOAD],
      [:find, [1, 'en'], :get, '/items/attribute_values/1/names/en'],
      [:list, [1], :get, '/items/attribute_values/1/names'],
      [:update, [1, 'en'], :put, '/items/attribute_values/1/names/en']
    ],
    'PlentyClient::Item::Barcode' => [
      [:activate_referrer, [1], :post, '/items/barcodes/1/referrer'],
      [:create, [], :post, '/items/barcodes'],
      [:deactivate_referrer, [1, 2], :delete, '/items/barcodes/1/referrer/2', NO_PAYLOAD],
      [:destroy, [1], :delete, '/items/barcodes/1', NO_PAYLOAD],
      [:find, [1], :get, '/items/barcodes/1'],
      [:list, [], :get, '/items/barcodes'],
      [:list_by_referrer, [1], :get, '/items/barcodes/referrer/1'],
      [:list_by_type, [1], :get, '/items/barcodes/type/1'],
      [:update, [1], :post, '/items/barcodes/1']
    ],
    'PlentyClient::Item::CrossSelling' => [
      [:create, [1], :post, '/items/1/item_cross_selling'],
      [:destroy, [1, 2], :delete, '/items/1/item_cross_selling/2', NO_PAYLOAD],
      [:list, [1], :get, '/items/1/item_cross_selling']
    ],
    'PlentyClient::Item::Image' => [
      [:create, [1], :post, '/items/1/images/upload'],
      [:destroy, [1, 2], :delete, '/items/1/images/2', NO_PAYLOAD],
      [:find, [1, 2], :get, '/items/1/images/2'],
      [:list, [1], :get, '/items/1/images'],
      [:list_variation_images, [1, 2], :get, '/items/1/variations/2/images'],
      [:update, [1, 2], :put, '/items/1/images/2'],
      [:upload, [1], :post, '/items/1/images/upload']
    ],
    'PlentyClient::Item::Image::Availability' => [
      [:create, [1, 2], :post, '/items/1/images/2/availabilities'],
      [:destroy, [1, 2], :delete, '/items/1/images/2/availabilities', NO_PAYLOAD],
      [:list, [1, 2], :get, '/items/1/images/2/availabilities']
    ],
    'PlentyClient::Item::Image::Name' => [
      [:create, [1, 2], :post, '/items/1/images/2/names'],
      [:destroy, [1, 2, 'en'], :delete, '/items/1/images/2/names/en', NO_PAYLOAD],
      [:find, [1, 2, 'en'], :get, '/items/1/images/2/names/en'],
      [:list, [1, 2], :get, '/items/1/images/2/names'],
      [:update, [1, 2, 'en'], :put, '/items/1/images/2/names/en']
    ],
    'PlentyClient::Item::Manufacturer' => [
      [:create, [], :post, '/items/manufacturers'],
      [:destroy, [1], :delete, '/items/manufacturers/1', NO_PAYLOAD],
      [:find, [1], :get, '/items/manufacturers/1'],
      [:list, [], :get, '/items/manufacturers'],
      [:update, [1], :put, '/items/manufacturers/1']
    ],
    'PlentyClient::Item::Manufacturer::Commission' => [
      [:create, [1], :post, '/items/manufacturers/1/commissions'],
      [:destroy, [1, 2], :delete, '/items/manufacturers/1/commissions/2', NO_PAYLOAD],
      [:find, [1, 2], :get, '/items/manufacturers/1/commissions/2'],
      [:list, [1], :get, '/items/manufacturers/1/commissions'],
      [:update, [1, 2], :put, '/items/manufacturers/1/commissions/2']
    ],
    'PlentyClient::Item::Property' => [
      [:create, [], :post, '/items/properties'],
      [:destroy, [1], :delete, '/items/properties/1', NO_PAYLOAD],
      [:find, [1], :get, '/items/properties/1'],
      [:list, [], :get, '/items/properties'],
      [:update, [1], :put, '/items/properties/1']
    ],
    'PlentyClient::Item::Property::MarketReference' => [
      [:create, [1], :post, '/items/properties/1/market_references'],
      [:destroy, [1, 2], :delete, '/items/properties/1/market_references/2', NO_PAYLOAD],
      [:find, [1, 2], :get, '/items/properties/1/market_references/2'],
      [:list, [1], :get, '/items/properties/1/market_references'],
      [:update, [1, 2], :put, '/items/properties/1/market_references/2']
    ],
    'PlentyClient::Item::Property::Name' => [
      [:create, [1], :post, '/items/properties/1/names'],
      [:destroy, [1, 'en'], :delete, '/items/properties/1/names/en', NO_PAYLOAD],
      [:find, [1, 'en'], :get, '/items/properties/1/names/en'],
      [:list, [1], :get, '/items/properties/1/names'],
      [:update, [1, 'en'], :put, '/items/properties/1/names/en']
    ],
    'PlentyClient::Item::PropertyGroup' => [
      [:create, [], :post, '/items/property_groups'],
      [:destroy, [1], :delete, '/items/property_groups/1', NO_PAYLOAD],
      [:find, [1], :get, '/items/property_groups/1'],
      [:list, [], :get, '/items/property_groups'],
      [:update, [1], :put, '/items/property_groups/1']
    ],
    'PlentyClient::Item::PropertyGroupName' => [
      [:create, [1], :post, 'items/property_groups/1/names'],
      [:destroy, [1, 'en'], :delete, 'items/property_groups/1/names/en', NO_PAYLOAD],
      [:find, [1, 'en'], :get, 'items/property_groups/1/names/en'],
      [:list, [1], :get, 'items/property_groups/1/names'],
      [:update, [1, 'en'], :put, 'items/property_groups/1/names/en']
    ],
    'PlentyClient::Item::SalesPrice' => [
      [:create, [], :post, '/items/sales_prices'],
      [:destroy, [1], :delete, '/items/sales_prices/1', NO_PAYLOAD],
      [:find, [1], :get, '/items/sales_prices/1'],
      [:list, [], :get, '/items/sales_prices'],
      [:update, [1], :put, '/items/sales_prices/1']
    ],
    'PlentyClient::Item::ShippingProfile' => [
      [:create, [1], :post, '/items/1/item_shipping_profiles'],
      [:destroy, [1, 2], :delete, '/items/1/item_shipping_profiles/2', NO_PAYLOAD],
      [:list, [1], :get, '/items/1/item_shipping_profiles']
    ],
    'PlentyClient::Item::Unit' => [
      [:create, [], :post, '/items/units'],
      [:destroy, [1], :delete, '/items/units/1', NO_PAYLOAD],
      [:find, [1], :get, '/items/units/1'],
      [:list, [], :get, '/items/units'],
      [:update, [1], :put, '/items/units/1']
    ],
    'PlentyClient::Item::UnitName' => [
      [:create, [1], :post, '/item/units/1/names'],
      [:destroy, [1, 'en'], :delete, '/item/units/1/names/en', NO_PAYLOAD],
      [:find, [1, 'en'], :get, '/item/units/1/names/en'],
      [:list, [1], :get, '/item/units/1/names'],
      [:update, [1, 'en'], :put, '/item/units/1/names/en']
    ],
    'PlentyClient::Item::Variation' => [
      [:all, [], :get, '/items/variations'],
      [:create, [1], :post, '/items/1/variations'],
      [:destroy, [1, 2], :delete, '/items/1/variations/2', NO_PAYLOAD],
      [:find, [1, 2], :get, '/items/1/variations/2'],
      [:list, [1], :get, '/items/1/variations'],
      [:update, [1, 2], :put, '/items/1/variations/2']
    ],
    'PlentyClient::Item::Variation::Barcode' => [
      [:create, [1, 2], :post, '/items/1/variations/2/variation_barcodes'],
      [:destroy, [1, 2, 3], :delete, '/items/1/variations/2/variation_barcodes/3', NO_PAYLOAD],
      [:find, [1, 2, 3], :get, '/items/1/variations/2/variation_barcodes/3'],
      [:list, [1, 2], :get, '/items/1/variations/2/variation_barcodes'],
      [:update, [1, 2, 3], :put, '/items/1/variations/2/variation_barcodes/3']
    ],
    'PlentyClient::Item::Variation::Bundle' => [
      [:create, [1, 2], :post, '/items/1/variations/2/variation_bundles'],
      [:destroy, [1, 2, 3], :delete, '/items/1/variations/2/variation_bundles/3', NO_PAYLOAD],
      [:find, [1, 2, 3], :get, '/items/1/variations/2/variation_bundles/3'],
      [:list, [1, 2], :get, '/items/1/variations/2/variation_bundles'],
      [:update, [1, 2, 3], :put, '/items/1/variations/2/variation_bundles/3']
    ],
    'PlentyClient::Item::Variation::Category' => [
      [:bulk_assign, [{}], :post, '/items/variations/variation_categories'],
      [:create, [1, 2], :post, '/items/1/variations/2/variation_categories'],
      [:destroy, [1, 2, 3], :delete, '/items/1/variations/2/variation_categories/3', NO_PAYLOAD],
      [:find, [1, 2, 3], :get, '/items/1/variations/2/variation_categories/3'],
      [:list, [1, 2], :get, '/items/1/variations/2/variation_categories'],
      [:update, [1, 2, 3], :put, '/items/1/variations/2/variation_categories/3']
    ],
    'PlentyClient::Item::Variation::Client' => [
      [:create, [1, 2], :post, '/items/1/variations/2/variation_clients'],
      [:destroy, [1, 2, 3], :delete, '/items/1/variations/2/variation_clients/3', NO_PAYLOAD],
      [:list, [1, 2], :get, '/items/1/variations/2/variation_clients']
    ],
    'PlentyClient::Item::Variation::DefaultCategory' => [
      [:create, [1, 2], :post, '/items/1/variations/2/variation_default_categories'],
      [:destroy, [1, 2, 3], :delete, '/items/1/variations/2/variation_default_categories/3', NO_PAYLOAD],
      [:find, [1, 2, 3], :get, '/items/1/variations/2/variation_default_categories/3'],
      [:list, [1, 2], :get, '/items/1/variations/2/variation_default_categories']
    ],
    'PlentyClient::Item::Variation::Description' => [
      [:create, [1, 2], :post, '/items/1/variations/2/descriptions'],
      [:destroy, [1, 2, 'en'], :delete, '/items/1/variations/2/descriptions/en', NO_PAYLOAD],
      [:find, [1, 2, 'en'], :get, '/items/1/variations/2/descriptions/en'],
      [:list, [1, 2], :get, '/items/1/variations/2/descriptions'],
      [:update, [1, 2, 'en'], :put, '/items/1/variations/2/descriptions/en']
    ],
    'PlentyClient::Item::Variation::Image' => [
      [:create, [1, 2], :post, '/items/1/variations/2/variation_images'],
      [:destroy, [1, 2, 3], :delete, '/items/1/variations/2/variation_images/3', NO_PAYLOAD],
      [:list_images_image_links, [1, 2], :get, '/items/1/images/2/variation_images'],
      [:list_items_image_links, [1], :get, '/items/1/variation_images'],
      [:list_variations_image_links, [1, 2], :get, '/items/1/variations/2/variation_images']
    ],
    'PlentyClient::Item::Variation::Market' => [
      [:create, [1, 2], :post, '/items/1/variations/2/variation_markets'],
      [:destroy, [1, 2, 3], :delete, '/items/1/variations/2/variation_markets/3', NO_PAYLOAD],
      [:list, [1, 2], :get, '/items/1/variations/2/variation_markets']
    ],
    'PlentyClient::Item::Variation::MarketIdentNumber' => [
      [:create, [1, 2], :post, '/items/1/variations/2/market_ident_numbers'],
      [:destroy, [1, 2, 3], :delete, '/items/1/variations/2/market_ident_numbers/3', NO_PAYLOAD],
      [:find, [1, 2, 3], :get, '/items/1/variations/2/market_ident_numbers/3'],
      [:list, [1, 2], :get, '/items/1/variations/2/market_ident_numbers'],
      [:update, [1, 2, 3], :put, '/items/1/variations/2/market_ident_numbers/3']
    ],
    'PlentyClient::Item::Variation::Property' => [
      [:bulk_create, [], :post, '/items/variations/variation_properties'],
      [:bulk_update, [], :put, '/items/variations/variation_properties'],
      [:create, [1, 2], :post, '/items/1/variations/2/variation_properties'],
      [:destroy, [1, 2, 3], :delete, '/items/1/variations/2/variation_properties/3', NO_PAYLOAD],
      [:destroy_all, [1, 2], :delete, '/items/1/variations/2/variation_properties', NO_PAYLOAD],
      [:find, [1, 2, 3], :get, '/items/1/variations/2/variation_properties/3'],
      [:list, [1, 2], :get, '/items/1/variations/2/variation_properties'],
      [:update, [1, 2, 3], :put, '/items/1/variations/2/variation_properties/3']
    ],
    'PlentyClient::Item::Variation::Property::Text' => [
      [:create, [1, 2, 3], :post, '/items/1/variations/2/variation_properties/3/texts'],
      [:destroy, [1, 2, 3, 'en'], :delete, '/items/1/variations/2/variation_properties/3/texts/en', NO_PAYLOAD],
      [:find, [1, 2, 3], :get, '/items/1/variations/2/variation_properties/3/texts'],
      [:find_by_language, [1, 2, 3, 'en'], :get, '/items/1/variations/2/variation_properties/3/texts/en'],
      [:update, [1, 2, 3, 'en'], :put, '/items/1/variations/2/variation_properties/3/texts/en']
    ],
    'PlentyClient::Item::Variation::SalesPrice' => [
      [:bulk_update, [], :put, '/items/variations/variation_sales_prices'],
      [:create, [1, 2], :post, '/items/1/variations/2/variation_sales_prices'],
      [:destroy, [1, 2, 3], :delete, '/items/1/variations/2/variation_sales_prices/3', NO_PAYLOAD],
      [:find, [1, 2, 3], :get, '/items/1/variations/2/variation_sales_prices/3'],
      [:list, [1, 2], :get, '/items/1/variations/2/variation_sales_prices'],
      [:update, [1, 2, 3], :put, '/items/1/variations/2/variation_sales_prices/3']
    ],
    'PlentyClient::Item::Variation::Sku' => [
      [:create, [1, 2], :post, '/items/1/variations/2/variation_skus'],
      [:destroy, [1, 2, 3], :delete, '/items/1/variations/2/variation_skus/3', NO_PAYLOAD],
      [:find, [1, 2, 3], :get, '/items/1/variations/2/variation_skus/3'],
      [:list, [1, 2], :get, '/items/1/variations/2/variation_skus'],
      [:update, [1, 2, 3], :put, '/items/1/variations/2/variation_skus/3']
    ],
    'PlentyClient::Item::Variation::Stock' => [
      [:list, [1, 2], :get, '/items/1/variations/2/stock'],
      [:list_stock_movements, [1, 2], :get, '/items/1/variations/2/stock/movements'],
      [:list_storage_locations, [1, 2], :get, '/items/1/variations/2/stock/storageLocations'],
      [:update_corrections, [1, 2], :put, '/items/1/variations/2/stock/correction'],
      [:update_incoming_items, [1, 2], :put, '/items/1/variations/2/stock/bookIncomingItems'],
      [:update_redistributions, [1, 2], :put, '/items/1/variations/2/stock/redistribute']
    ],
    'PlentyClient::Item::Variation::Supplier' => [
      [:create, [1, 2], :post, '/items/1/variations/2/variation_suppliers'],
      [:destroy, [1, 2, 3], :delete, '/items/1/variations/2/variation_suppliers/3', NO_PAYLOAD],
      [:find, [1, 2, 3], :get, '/items/1/variations/2/variation_suppliers/3'],
      [:list, [1, 2], :get, '/items/1/variations/2/variation_suppliers'],
      [:update, [1, 2, 3], :put, '/items/1/variations/2/variation_suppliers/3']
    ],
    'PlentyClient::Item::Variation::Warehouse' => [
      [:create, [1, 2], :post, '/items/1/variations/2/variation_warehouses'],
      [:destroy, [1, 2, 3], :delete, '/items/1/variations/2/variation_warehouses/3', NO_PAYLOAD],
      [:find, [1, 2, 3], :get, '/items/1/variations/2/variation_warehouses/3'],
      [:list, [1, 2], :get, '/items/1/variations/2/variation_warehouses'],
      [:update, [1, 2, 3], :put, '/items/1/variations/2/variation_warehouses/3']
    ],
    'PlentyClient::ItemSet' => [
      [:create, [], :post, '/item_sets'],
      [:destroy, [1], :put, '/item_sets/1'],
      [:destroy_sets, [], :put, '/item_sets'],
      [:find, [1], :get, '/item_sets/1'],
      [:list, [], :get, '/item_sets'],
      [:update, [1], :put, '/item_sets/1'],
      [:update_sets, [], :put, '/item_sets']
    ],
    'PlentyClient::ItemSet::Component' => [
      [:create, [1], :post, '/item_sets/1/components'],
      [:destroy_item_set_component, [1, 2], :delete, '/item_sets/1/components/2'],
      [:destroy_item_sets_components, [1], :delete, '/item_sets/1/components'],
      [:list_item_set_component, [1, 2], :get, '/item_sets/1/components/2'],
      [:list_item_sets_components, [1], :get, '/item_sets/1/components'],
      [:update_item_set_component, [1, 2], :put, '/item_sets/1/components/2'],
      [:update_item_sets_components, [1], :put, '/item_sets/1/components']
    ],
    'PlentyClient::ItemSet::Config' => [
      [:find, [1], :get, '/item_sets/1/config'],
      [:update, [1], :put, '/item_sets/1/config']
    ],
    'PlentyClient::Listing' => [
      [:create, [], :post, '/listings'],
      [:destroy, [1], :delete, '/listings/1'],
      [:find, [1], :get, '/listings/1'],
      [:list, [], :get, '/listings'],
      [:update, [1], :post, '/listings/1']
    ],
    'PlentyClient::Listing::LayoutTemplate' => [
      [:create, [], :post, '/listings/layout_templates'],
      [:destroy, [1], :delete, '/listings/layout_templates/1'],
      [:find, [1], :get, '/listings/layout_templates/1']
    ],
    'PlentyClient::Listing::Market' => [
      [:create, [], :post, '/listings/markets'],
      [:destroy, [1], :delete, '/listings/markets/1'],
      [:find, [1], :get, '/listings/markets/1'],
      [:list, [], :get, '/listings/markets'],
      [:start, [1], :post, '/listings/markets/start/1'],
      [:update, [1], :put, '/listings/markets/1'],
      [:verify, [1], :post, '/listings/markets/verify/1']
    ],
    'PlentyClient::Listing::Market::Directory' => [
      [:create, [], :post, '/listings/markets/directories'],
      [:destroy, [1], :delete, '/listings/markets/directories/1'],
      [:find, [1], :get, '/listings/markets/directories/1'],
      [:update, [1], :put, '/listings/markets/directories/1']
    ],
    'PlentyClient::Listing::Market::History' => [
      [:end, [1], :delete, '/listings/markets/histories/end/1'],
      [:find, [1], :get, '/listings/markets/histories/1'],
      [:list, [], :get, '/listings/markets/histories'],
      [:relist, [1], :post, '/listings/markets/histories/relist/1'],
      [:update, [1], :put, '/listings/markets/histories/update/1'],
      [:update_many, [], :put, '/listings/markets/histories/update']
    ],
    'PlentyClient::Listing::Market::Info' => [
      [:list, [], :get, '/listings/markets/infos']
    ],
    'PlentyClient::Listing::Market::Text' => [
      [:create, [], :post, '/listings/markets/texts'],
      [:destroy, [1], :delete, '/listings/markets/texts/1'],
      [:find, [1], :get, '/listings/markets/texts/1'],
      [:list, [], :get, '/listings/markets/texts'],
      [:update, [1], :put, '/listings/markets/texts/1']
    ],
    'PlentyClient::Listing::OptionTemplate' => [
      [:create, [], :post, '/listings/option_templates'],
      [:destroy, [1], :delete, '/listings/option_templates/1'],
      [:find, [1], :get, '/listings/option_templates/1'],
      [:preview, [], :get, '/listings/option_templates/preview'],
      [:update, [1], :put, '/listings/option_templates/1']
    ],
    'PlentyClient::Listing::ShippingProfile' => [
      [:find, [1], :get, '/listings/shipping_profiles/1'],
      [:list, [], :get, '/listings/shipping_profiles']
    ],
    'PlentyClient::Listing::StockDependenceType' => [
      [:find, [1], :get, '/listings/types/1'],
      [:list, [], :get, '/listings/types']
    ],
    'PlentyClient::Listing::Type' => [
      [:find, [1], :get, '/listings/types/1'],
      [:list, [], :get, '/listings/types']
    ],
    'PlentyClient::Market::Credentials' => [
      [:create, [], :post, '/markets/credentials'],
      [:destroy, [1], :delete, '/markets/credentials/1'],
      [:find, [1], :get, '/markets/credentials/1'],
      [:list, [], :get, '/markets/credentials'],
      [:update, [1], :put, '/markets/credentials/1']
    ],
    'PlentyClient::Market::Ebay::Authentication' => [
      [:find_login_url, [], :get, '/markets/ebay/auth/login'],
      [:refrest_token, [], :put, '/markets/ebay/auth/refresh-token']
    ],
    'PlentyClient::Market::Ebay::PartsFitment' => [
      [:create, [], :post, '/markets/ebay/parts-fitments'],
      [:destroy, [1], :delete, '/markets/ebay/parts-fitments/1'],
      [:find, [1], :get, '/markets/ebay/parts-fitments/1'],
      [:list, [], :get, '/markets/ebay/parts-fitments'],
      [:search, [], :get, '/markets/ebay/parts-fitments/search'],
      [:update, [1], :put, '/markets/ebay/parts-fitments/1']
    ],
    'PlentyClient::Market::Ebay::ShopCategory' => [
      [:list, [], :get, '/markets/ebay/shop_categories']
    ],
    'PlentyClient::Order' => [
      [:create, [], :post, '/orders'],
      [:destroy, [1], :delete, '/orders/1'],
      [:find, [1], :get, '/orders/1'],
      [:list, [], :get, '/orders'],
      [:list_contacts_orders, [1], :get, '/orders/contacts/1'],
      [:list_package_numbers, [1], :get, '/orders/1/packagenumbers'],
      [:update, [1], :put, '/orders/1']
    ],
    'PlentyClient::Order::ContactWish' => [
      [:find, [1], :get, '/orders/1/contactWish']
    ],
    'PlentyClient::Order::CouponCode' => [
      [:update, [1, 'SOMECOUPON'], :post, '/orders/1/coupons/SOMECOUPON']
    ],
    'PlentyClient::Order::CouponCode::Contact' => [
      [:update, [1], :post, '/orders/coupons/codes/contacts/1']
    ],
    'PlentyClient::Order::CouponCode::Validation' => [
      [:update, ['SOMECOUPON'], :post, '/orders/coupons/codes/SOMECOUPON']
    ],
    'PlentyClient::Order::Currency' => [
      [:find, ['EUR'], :get, '/orders/currencies/EUR'],
      [:find_countries, ['EUR'], :get, '/orders/currencies/EUR/countries'],
      [:find_currency, [1], :get, '/orders/currencies/countries/1'],
      [:list, [], :get, '/orders/currencies']
    ],
    'PlentyClient::Order::Date' => [
      [:find, [1, 2], :get, '/orders/1/dates/2'],
      [:find_date_type_name, [1, 'en'], :get, '/orders/dates/types/1/names/en'],
      [:list, [1], :get, '/orders/1/dates'],
      [:list_date_type_names, [1], :get, '/orders/dates/types/1/names']
    ],
    'PlentyClient::Order::Item' => [
      [:destroy, [1, 2], :delete, '/orders/1/items/2', NO_PAYLOAD]
    ],
    'PlentyClient::Order::Item::SerialNumber' => [
      [:find, [1, 2], :get, '/orders/1/items/2/serialNumbers'],
      [:list, [1], :get, '/orders/1/items/serialNumbers']
    ],
    'PlentyClient::Order::Referrer' => [
      [:create, [1], :post, '/orders/referrers/1'],
      [:list, [], :get, '/orders/referrers']
    ],
    'PlentyClient::Order::Shipping::Country' => [
      [:list, [], :get, '/orders/shipping/countries']
    ],
    'PlentyClient::Order::Shipping::Information' => [
      [:create, [], :post, '/orders/shipping/shipping_information'],
      [:destroy, [1], :delete, '/orders/1/shipping/shipping_information'],
      [:list, [1], :get, '/orders/1/shipping/shipping_information'],
      [:update_data, [1], :put, '/orders/1/shipping/shipping_information/additional_data'],
      [:update_status, [1], :put, '/orders/1/shipping/shipping_information/status']
    ],
    'PlentyClient::Order::Shipping::Package' => [
      [:create, [1], :post, '/orders/1/shipping/packages'],
      [:destroy, [1, 2], :delete, '/orders/1/shipping/packages/2'],
      [:destroy_all, [1], :delete, '/orders/1/shipping/packages'],
      [:find, [1, 2], :get, '/orders/1/shipping/packages/2'],
      [:list, [1], :get, '/orders/1/shipping/packages'],
      [:update, [1, 2], :put, '/orders/1/shipping/packages/2']
    ],
    'PlentyClient::Order::Shipping::Profile' => [
      [:find, [1], :get, '/orders/shipping/presets/1'],
      [:list, [], :get, '/orders/shipping/presets']
    ],
    'PlentyClient::Order::Shipping::ServiceProvider' => [
      [:find, [1], :get, '/orders/shipping/shipping_service_providers/1'],
      [:list, [], :get, '/orders/shipping/shipping_service_providers']
    ],
    'PlentyClient::Order::StatusHistory' => [
      [:find, [1], :get, '/orders/1/status-history'],
      [:list, [], :get, '/orders/status-history']
    ],
    'PlentyClient::OrderSummary' => [
      [:create, [], :post, '/order_summaries'],
      [:destroy, [1], :delete, '/order_summaries/1'],
      [:find, [1], :get, '/order_summaries/1'],
      [:find_by_address, [1], :get, '/order_summaries/orders/1'],
      [:find_by_contact, [1], :get, '/order_summaries/contacts/1'],
      [:list, [], :get, '/order_summaries'],
      [:update, [1], :put, '/order_summaries/1']
    ],
    'PlentyClient::Payment' => [
      [:find, [1], :get, '/payments/1'],
      [:list, [], :get, '/payments'],
      [:list_by_entry_date, [], :get, '/payments/entrydate'],
      [:list_by_import_date, [], :get, '/payments/importdate'],
      [:update, [1], :put, '/payments/1']
    ],
    'PlentyClient::Payment::Contact' => [
      [:create, [1, 2], :post, '/payment/1/contact/2'],
      [:destroy, [1], :delete, '/payment/1/contact']
    ],
    'PlentyClient::Payment::Method' => [
      [:create, [], :post, '/payments/methods'],
      [:create_ebics_account, [], :post, '/payments/methods/ebics'],
      [:find, [1], :get, '/payments/methods/1'],
      [:find_by_plugin_key, [1], :get, '/payments/methods/1'],
      [:list, [], :get, '/payments/methods'],
      [:list_ebics_accounts, [], :get, '/payments/methods/ebics'],
      [:update, [], :put, '/payments/methods']
    ],
    'PlentyClient::Payment::MethodName' => [
      [:list, [], :get, '/payments/methodNames'],
      [:list_for_payment_method, [1], :get, '/payments/methodNames/1'],
      [:list_for_payment_method_by_lang, [1, 'en'], :get, '/payments/methodNames/1/en']
    ],
    'PlentyClient::Payment::Order' => [
      [:create, [1, 2], :post, '/payment/1/order/2'],
      [:destroy, [1], :delete, '/payment/1/order'],
      [:list, [1], :get, '/payments/orders/1']
    ],
    'PlentyClient::Payment::Property' => [
      [:create, [], :post, '/payments/properties'],
      [:find, [1], :get, '/payments/properties/1'],
      [:list, [], :get, '/payments/properties'],
      [:list_by_payment_id, [1], :get, '/payments/1/properties'],
      [:list_by_type_and_value, [1, 2], :get, '/payments/property/1/2'],
      [:update, [], :put, '/payments/properties']
    ],
    'PlentyClient::Payment::Property::Type' => [
      [:create, [], :post, '/payments/properties/types'],
      [:find, [1], :get, '/payments/properties/types/1'],
      [:list, [], :get, '/payments/properties/types'],
      [:update, [], :put, '/payments/properties/types']
    ],
    'PlentyClient::Payment::Property::Type::Name' => [
      [:create, [], :post, '/payments/properties/types/names'],
      [:find, [1], :get, '/payments/properties/types/names/1'],
      [:list, ['en'], :get, '/payments/properties/types/names/en'],
      [:update, [], :put, '/payments/properties/types/names']
    ],
    'PlentyClient::Payment::Status' => [
      [:find, [1], :get, '/payments/status/1']
    ],
    'PlentyClient::Payment::Transaction' => [
      [:find, [1], :get, '/payments/transactions/1']
    ],
    'PlentyClient::Rest::Pim::Variations' => [
      [:update, [], :put, '/pim/variations', []]
    ],
    'PlentyClient::SalesPrice::Account' => [
      [:activate, [1], :post, '/items/sales_prices/1/accounts'],
      [:deactivate, [1, 2, 3], :delete, '/items/sales_prices/1/accounts/2/3', NO_PAYLOAD],
      [:list, [1], :get, '/items/sales_prices/1/accounts']
    ],
    'PlentyClient::SalesPrice::Country' => [
      [:activate, [1], :post, '/items/sales_prices/1/countries'],
      [:deactivate, [1, 2], :delete, '/items/sales_prices/1/countries/2', NO_PAYLOAD],
      [:list, [1], :get, '/items/sales_prices/1/countries']
    ],
    'PlentyClient::SalesPrice::Currency' => [
      [:activate, [1], :post, '/items/sales_prices/1/currencies'],
      [:deactivate, [1, 'EUR'], :delete, '/items/sales_prices/1/currencies/EUR', NO_PAYLOAD],
      [:list, [1], :get, '/items/sales_prices/1/currencies']
    ],
    'PlentyClient::SalesPrice::CustomerClass' => [
      [:activate, [1], :post, '/items/sales_prices/1/customer_classes'],
      [:deactivate, [1, 2], :delete, '/items/sales_prices/1/customer_classes/2', NO_PAYLOAD],
      [:list, [1], :get, '/items/sales_prices/1/customer_classes']
    ],
    'PlentyClient::SalesPrice::Name' => [
      [:create, [1], :post, '/items/sales_prices/1/names'],
      [:destroy, [1, 'en'], :delete, '/items/sales_prices/1/names/en', NO_PAYLOAD],
      [:list, [1], :get, '/items/sales_prices/1/names'],
      [:list_by_lang, [1, 'en'], :get, '/items/sales_prices/1/names/en'],
      [:update, [1, 'en'], :post, '/items/sales_prices/1/names/en']
    ],
    'PlentyClient::SalesPrice::OnlineStore' => [
      [:activate, [1], :post, '/items/sales_prices/1/online_stores'],
      [:deactivate, [1, 2], :delete, '/items/sales_prices/1/online_stores/2', NO_PAYLOAD],
      [:list, [1], :get, '/items/sales_prices/1/online_stores']
    ],
    'PlentyClient::SalesPrice::Referrer' => [
      [:activate, [1], :post, '/items/sales_prices/1/referrers'],
      [:deactivate, [1, 2], :delete, '/items/sales_prices/1/referrers/2', NO_PAYLOAD],
      [:list, [1], :get, '/items/sales_prices/1/referrers']
    ],
    'PlentyClient::Stock' => [
      [:list, [], :get, '/stockmanagement/stock'],
      [:list_by_type, [1], :get, '/stockmanagement/stock/types/1'],
      [:redistribute, [], :put, '/stockmanagement/stock/redistribute']
    ],
    'PlentyClient::Ticket' => [
      [:add_message, [1], :post, '/tickets/1'],
      [:create, [], :post, '/tickets'],
      [:list, [], :get, '/tickets'],
      [:update, [1], :put, '/tickets/1']
    ],
    'PlentyClient::V2::Item::Property' => [
      [:create, [], :post, '/v2/properties'],
      [:destroy, [1], :delete, '/v2/properties/1', NO_PAYLOAD],
      [:find, [1], :get, '/v2/properties/1'],
      [:list, [], :get, '/v2/properties'],
      [:update, [1], :put, '/v2/properties/1']
    ],
    'PlentyClient::V2::Item::Property::Name' => [
      [:create, [], :post, '/v2/properties/names'],
      [:destroy, [1], :delete, '/v2/properties/names/1', NO_PAYLOAD],
      [:find, [1], :get, '/v2/properties/names/1'],
      [:update, [1], :put, '/v2/properties/names/1']
    ],
    'PlentyClient::V2::Item::PropertyGroup' => [
      [:create, [], :post, '/v2/properties/groups'],
      [:destroy, [1], :delete, '/v2/properties/groups/1', NO_PAYLOAD],
      [:find, [1], :get, '/v2/properties/groups/1'],
      [:list, [], :get, '/v2/properties/groups'],
      [:update, [1], :put, '/v2/properties/groups/1']
    ],
    'PlentyClient::V2::Item::PropertyGroup::Name' => [
      [:create, [], :post, '/v2/properties/groups/names'],
      [:destroy, [1], :delete, '/v2/properties/groups/names/1', NO_PAYLOAD],
      [:find, [1], :get, '/v2/properties/groups/names/1'],
      [:update, [1], :put, '/v2/properties/groups/names/1']
    ],
    'PlentyClient::Warehouse::Location' => [
      [:list, [1], :get, '/warehouses/1/locations']
    ],
    'PlentyClient::Warehouse::Location::Dimension' => [
      [:list, [1], :get, '/warehouses/1/locations/dimensions']
    ],
    'PlentyClient::Warehouse::Location::Level' => [
      [:list, [1], :get, '/warehouses/1/locations/levels']
    ],
    'PlentyClient::Warehouse::Management' => [
      [:find_location, [1, 2], :get, '/stockmanagement/warehouses/1/management/storageLocations/2'],
      [:find_racks, [1, 2], :get, '/stockmanagement/warehouses/1/management/racks/2'],
      [:list_locations, [1], :get, '/stockmanagement/warehouses/1/management/storageLocations'],
      [:list_racks, [1], :get, '/stockmanagement/warehouses/1/management/racks']
    ],
    'PlentyClient::Warehouse::Stock' => [
      [:book_incoming, [1], :put, '/stockmanagement/warehouses/1/stock/bookIncomingItems'],
      [:correction, [1], :put, '/stockmanagement/warehouses/1/stock/correction'],
      [:list, [1], :get, '/stockmanagement/warehouses/1/stock'],
      [:list_by_location, [1], :get, '/stockmanagement/warehouses/1/stock/storageLocations'],
      [:list_movements, [1], :get, '/stockmanagement/warehouses/1/stock/movements']
    ],
    'PlentyClient::Webstore' => [
      [:list, [], :get, '/webstores']
    ]
  }.freeze

  # PlentyClient::Concerns::RestRoutes gives a module the five boilerplate routes
  # of its base_path, so they are not visible on the module itself.
  FROM_REST_ROUTES = {
    'PlentyClient::Warehouse' => [
      # #update and #destroy are dropped with skip_rest_routes
      [:create, [], :post, '/stockmanagement/warehouses'],
      [:list, [], :get, '/stockmanagement/warehouses'],
      [:find, [1], :get, '/stockmanagement/warehouses/1']
    ],
    'PlentyClient::Warehouse::Location' => [
      [:create, [], :post, '/warehouses/locations'],
      [:find, [1], :get, '/warehouses/locations/1'],
      [:update, [1], :put, '/warehouses/locations/1'],
      [:destroy, [1], :delete, '/warehouses/locations/1']
    ],
    'PlentyClient::Warehouse::Location::Dimension' => [
      [:create, [], :post, '/warehouses/locations/dimensions'],
      [:find, [1], :get, '/warehouses/locations/dimensions/1'],
      [:update, [1], :put, '/warehouses/locations/dimensions/1'],
      [:destroy, [1], :delete, '/warehouses/locations/dimensions/1']
    ],
    'PlentyClient::Warehouse::Location::Level' => [
      [:create, [], :post, '/warehouses/locations/levels'],
      [:find, [1], :get, '/warehouses/locations/levels/1'],
      [:update, [1], :put, '/warehouses/locations/levels/1'],
      [:destroy, [1], :delete, '/warehouses/locations/levels/1']
    ]
  }.freeze

  # The bulk delete endpoints go through #request directly, because Faraday
  # treats the second argument of #delete as query parameters.
  BULK_DELETES = {
    'PlentyClient::Rest::Pim::Variations::Markets' => '/pim/variations/markets',
    'PlentyClient::Rest::Pim::Variations::Properties' => '/pim/variations/properties',
    'PlentyClient::Rest::Pim::Variations::SalesPrices' => '/pim/variations/sales_prices'
  }.freeze

  # Modules that can send a request because they include PlentyClient::Request,
  # but that declare no route of their own. The four Order ones are placeholders:
  # they list the endpoints of the PlentyMarkets API in comments and nothing else.
  NAMESPACES = [
    'PlentyClient::Market',
    'PlentyClient::Order::Item::Date',
    'PlentyClient::Order::Item::Property',
    'PlentyClient::Order::Property',
    'PlentyClient::Order::Shipping'
  ].freeze
end
