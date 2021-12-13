# frozen_string_literal: true

require "active_support/all"
require "grape"

module Grape
  module ExtraValidators
    class MinimumValue < Grape::Validations::Base
      def validate_param!(attr_name, params)
        return if !@required && params[attr_name].blank?

        minimum_value = @option.instance_of?(Proc) ? @option.call(params) : @option
        return if minimum_value.blank?

        value = params[attr_name].to_i
        return if value >= minimum_value

        message = "must be equal to or above #{minimum_value}"

        fail Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
      end
    end
  end
end
