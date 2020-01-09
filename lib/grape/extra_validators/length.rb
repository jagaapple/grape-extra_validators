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
        return if !@required && params[attr_name].blank?

        if @option.instance_of?(Range)
          return if @option.include?(params[attr_name].length)

          message = "must be #{@option.first} to #{@option.last} characters long"
          fail Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
        end

        return if params[attr_name].length == @option

        unit = "character".pluralize(@option)
        message = "must be #{@option} #{unit} long"
        fail Grape::Exceptions::Validation.new(params: [@scope.full_name(attr_name)], message: message)
      end
    end
  end
end
