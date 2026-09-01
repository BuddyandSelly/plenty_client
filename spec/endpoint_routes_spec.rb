# frozen_string_literal: true

require 'spec_helper'

# Drives the tables in spec/support/endpoint_routes.rb: every endpoint method of
# the gem is called with placeholder arguments and has to hand exactly one verb
# and one path to PlentyClient::Request.
RSpec.describe 'the endpoint routes of the gem' do
  def self.expected_arguments(path, payload)
    case payload
    when nil then [path, {}]
    when EndpointRoutes::NO_PAYLOAD then [path]
    else [path, payload]
    end
  end

  def self.it_sends(const_name, method_name, args, verb, path, payload)
    expected = expected_arguments(path, payload)

    it "##{method_name} sends #{verb.to_s.upcase} #{path}" do
      target = Object.const_get(const_name)
      expect(target).to receive(verb).with(*expected)
      target.public_send(method_name, *args)
    end
  end

  # Every module that includes PlentyClient::Request can send a request, so every
  # one of them has to appear in one of the tables. Without this, a new endpoint
  # module would silently go untested.
  it 'accounts for every module that can send a request' do
    found = []
    collect = lambda do |mod, seen|
      next if seen.include?(mod)

      seen << mod
      found << mod.to_s if %i[get post put patch delete].all? { |verb| mod.respond_to?(verb, true) }
      mod.constants(false).each do |const|
        value = mod.const_get(const, false)
        collect.call(value, seen) if value.is_a?(Module)
      end
    end
    collect.call(PlentyClient, [])

    tabled = EndpointRoutes::ALL.keys + EndpointRoutes::FROM_REST_ROUTES.keys +
             EndpointRoutes::BULK_DELETES.keys + EndpointRoutes::NAMESPACES
    expect(found.sort).to eq(tabled.uniq.sort)
  end

  EndpointRoutes::ALL.each do |const_name, routes|
    describe const_name do
      routes.each do |(method_name, args, verb, path, payload)|
        it_sends(const_name, method_name, args, verb, path, payload)
      end
    end
  end

  EndpointRoutes::FROM_REST_ROUTES.each do |const_name, routes|
    describe "#{const_name} (through PlentyClient::Concerns::RestRoutes)" do
      routes.each do |(method_name, args, verb, path, payload)|
        it_sends(const_name, method_name, args, verb, path, payload)
      end
    end
  end

  EndpointRoutes::BULK_DELETES.each do |const_name, path|
    describe const_name do
      it "#delete sends DELETE #{path} through #request" do
        target = Object.const_get(const_name)
        expect(target).to receive(:request).with(:delete, path, [])
        target.delete
      end
    end
  end

  EndpointRoutes::NAMESPACES.each do |const_name|
    describe const_name do
      it 'declares no route of its own' do
        target = Object.const_get(const_name)
        expect(target.singleton_class.instance_methods(false)).to be_empty
      end
    end
  end
end
