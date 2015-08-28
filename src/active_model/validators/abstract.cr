module ActiveModel
  module Validators
    abstract class AbstractValidator
      abstract def validate_value(value) : Bool

      abstract def get_error_message(attribute) : String

      def validate(record, attribute, value)
        unless validate_value(value)
          record.errors.add(attribute, get_error_message(attribute))
          return false
        end

        true
      end
    end
  end
end