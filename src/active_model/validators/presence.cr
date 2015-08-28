module ActiveModel
  module Validators
    class PresenceValidator < AbstractValidator
      def get_error_message(attribute)
        "\"#{attribute}\" can't be blank"
      end

      def validate_value(value)
        value.responds_to?(:empty?) ? !value.empty? : !!value
      end
    end
  end
end