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
          message = "length cannot be validated (wrong parameter type: #{value.class})"
          fail Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
        end

        # If option is a range we check if value length included in the range
        message = if @option.instance_of?(Range)
                    validate_with_range(value)
                  else
                    validate_with_number(value)
                  end
        fail Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message) unless message.blank?
      end

      private def validate_with_range(value)
        # if option is a range, we check if value is included in range
        return nil if @option.include?(value.length)

        if value.is_a? String
          "must be #{@option.first} to #{@option.last} characters long"
        else
          "must have #{@option.first} to #{@option.last} items"
        end
      end

      private def validate_with_number(value)
        # If option is a single value we check if length matches it
        return nil if value.length == @option

        if value.is_a? String
          unit = "character".pluralize(@option)
          "must be #{@option} #{unit} long"
        else
          # Array
          unit = "item".pluralize(@option)
          "must have exactly #{@option} #{unit}"
        end
      end
    end
  end
end
