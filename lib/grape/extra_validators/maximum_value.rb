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

        value = params[attr_name].to_i
        return if value <= @option

        message = "must be below #{@option}"

        fail Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
      end
    end
  end
end
