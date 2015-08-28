module ActiveModel
  module Validators
    class NumericalityValidator < AbstractValidator
      def get_error_message(attribute)
        "\"#{attribute}\" is not a number"
      end

      def validate_value(value)
        value.is_a?(Number)
      end
    end
  end
end