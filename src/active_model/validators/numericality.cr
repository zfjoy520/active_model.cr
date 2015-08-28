module ActiveModel
  module Validators
    class NumericalityValidator < AbstractValidator
      def validate(record, attribute, value)
        errors = [] of String
        if !value.is_a?(Number)
          errors.push "\"#{attribute}\" is not a number"
        elsif only_integer? && !value.is_a?(Int)
          errors.push "\"#{attribute}\" must be an integer"
        end

        record.errors.add(attribute, errors)

        errors.empty?
      end

      private def only_integer?
        options.has_key?(:only_integer) && options[:only_integer]
      end
    end
  end
end