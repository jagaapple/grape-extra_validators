# frozen_string_literal: true

require "active_support/all"
require "grape"

module Grape
  module ExtraValidators
    class MaximumLength < Grape::Validations::Base
      # ------------------------------------------------------------------------------------------------------------------------
      # Methods
      # ------------------------------------------------------------------------------------------------------------------------
      # Public Methods
      # ------------------------------------------------------------------------------------------------------------------------
      def validate_param!(attr_name, params)
        value = params[attr_name]
        return if !@required && value.blank?

        unless [String, Array].include? value.class
          message = "maximum length cannot be validated (wrong parameter type: #{value.class})"
          fail Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
        end

        return if value.length <= @option

        if value.is_a? String
          unit = "character".pluralize(@option)
          message = "must be up to #{@option} #{unit} long"
        else # Array
          unit = "item".pluralize(@option)
          message = "must have up to #{@option} #{unit}"
        end
        fail Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
      end
    end
  end
end
