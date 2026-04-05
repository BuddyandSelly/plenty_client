$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'webmock/rspec'
require 'debug'
require 'uri'

require 'plenty_client'
WebMock.disable_net_connect!

def parse_query(query_string)
  URI.decode_www_form(query_string).each_with_object({}) do |(k, v), hash|
    (hash[k] ||= []) << v
  end
end
