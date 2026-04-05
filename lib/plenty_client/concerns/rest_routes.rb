# frozen_string_literal: true

# Quickly extends boilerplate paths that comply with the schema:
# POST BASE_PATH => create
# GET BASE_PATH/:id => find
# PUT BASE_PATH/:id => update
# DELETE BASE_PATH/:id => destroy
# You can undefine unnecessary methods by adding a call to
# #skip_rest_routes in the class body:
# class Someclass
#   skip_rest_routes :find, :destroy
# end

# Usage:
# Extend this module in your class/module and define `self.base_path`
# Do keep in mind that this method should be private or protected.
#
# class Someclass
#   extend PlentyClient::Concerns::RestRoutes
#
#   # method definition returns method name as a Symbol
#   private_class_method def self.base_path
#     '/my_base_path'
#   end
#
#   # or
#   def self.base_path
#     '/my_base_path'
#   end
#   private_class_method :base_path
#
#   # or
#   class << self
#     private
#
#     def base_path
#       '/my_base_path'
#     end
#   end
# end

module PlentyClient
  module Concerns
    module RestRoutes
      # Undefines class methods in modules/classes extending this module.
      # You don't have to do it if you overload the method explicitly.
      def skip_rest_routes(*paths)
        instance_exec(paths) do |p|
          p.each { |mn| undef :"#{mn}" }
        end
      end

      def create(headers = {}, &)
        post(base_path, headers, &)
      end

      def list(headers = {}, &)
        get(base_path, headers, &)
      end

      def find(id, headers = {}, &)
        get(single_path(id), headers, &)
      end

      def update(id, headers = {}, &)
        put(single_path(id), headers, &)
      end

      def destroy(id, headers = {}, &)
        delete(single_path(id), headers, &)
      end

      private

      def single_path(id)
        base_path + "/#{id}"
      end
    end
  end
end
