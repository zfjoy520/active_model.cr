module ActiveModel
  module Validators
    class PresenceValidator < AbstractValidator
      def validate(record, attribute, value)
        value.responds_to?(:empty?) ? !value.empty? : !!value
      end
    end
  end
end