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
        return if !@required && params[attr_name].blank?
        return if params[attr_name].length <= @option

        unit = "character".pluralize(@option)
        message = "must be up to #{@option} #{unit} long"

        fail Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
      end
    end
  end
end
