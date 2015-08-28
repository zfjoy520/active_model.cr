module ActiveModel
  module Validators
    class PresenceValidator < AbstractValidator
      def validate(record, attribute, value)
        unless validate_value(value)
          record.errors.add(attribute, "\"#{attribute}\" can't be blank")
          return false
        end

        true
      end

      private def validate_value(value)
        value.responds_to?(:empty?) ? !value.empty? : !!value
      end
    end
  end
end