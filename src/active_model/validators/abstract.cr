module ActiveModel
  module Validators
    abstract class AbstractValidator
      getter :options

      def initialize(@options = {} of Symbol => Bool)
      end

      def validate(record, attribute, value)
        unless validate_value(value)
          record.errors.add(attribute, get_error_message(attribute))
          return false
        end
        true
      end

      abstract def validate(record, attribute, value)
    end
  end
end