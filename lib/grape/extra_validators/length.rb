# frozen_string_literal: true

require "active_support/all"
require "grape"

module Grape
  module ExtraValidators
    class Length < Grape::Validations::Base
      # ------------------------------------------------------------------------------------------------------------------------
      # Methods
      # ------------------------------------------------------------------------------------------------------------------------
      # Public Methods
      # ------------------------------------------------------------------------------------------------------------------------
      def validate_param!(attr_name, params)
        value = params[attr_name]
        return if !@required && value.blank?

        unless [String, Array].include? value.class
          fail Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: "length cannot be validated (wrong parameter type: #{value.class})")
        end

        # If option is a range we check if value length included in the range
        if @option.instance_of?(Range)
          return if @option.include?(value.length)

          if value.is_a? String
            message = "must be #{@option.first} to #{@option.last} characters long"
          else # Array
            message = "must have #{@option.first} to #{@option.last} items"
          end
          fail Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
        else
          # If option is a single value we check if length matches it
          return if value.length == @option
          if value.is_a? String
            unit = "character".pluralize(@option)
            message = "must be #{@option} #{unit} long"
          else # Array
            unit = "item".pluralize(@option)
            message = "must have exactly #{@option} #{unit}"
          end
          fail Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
        end
      end
    end
  end
end
