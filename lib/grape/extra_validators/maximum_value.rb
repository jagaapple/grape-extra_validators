# frozen_string_literal: true

require "active_support/all"
require "grape"

module Grape
  module ExtraValidators
    class MaximumValue < Grape::Validations::Base
      # ------------------------------------------------------------------------------------------------------------------------
      # Methods
      # ------------------------------------------------------------------------------------------------------------------------
      # Public Methods
      # ------------------------------------------------------------------------------------------------------------------------
      def validate_param!(attr_name, params)
        return if !@required && params[attr_name].blank?

        maximum_value = @option.instance_of?(Proc) ? @option.call(params) : @option
        return if maximum_value.blank?

        value = params[attr_name].to_i
        return if value <= maximum_value

        message = "must be equal to or below #{maximum_value}"

        fail Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
      end
    end
  end
end
