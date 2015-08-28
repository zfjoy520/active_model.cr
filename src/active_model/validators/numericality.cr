module ActiveModel
  module Validators
    class NumericalityValidator < AbstractValidator
      def validate(record, attribute, value)
        errors = [] of String
        if !value.is_a?(Number)
          errors.push "\"#{attribute}\" is not a number"
        elsif verifies?(:only_integer) && !value.is_a?(Int)
          errors.push "\"#{attribute}\" must be an integer"
        end

        if value.is_a?(Number)
          if verifies?(:greater_than) && options[:greater_than].is_a?(Number)
            target = options[:greater_than].to_s.to_f # required because of compilation errors
            errors.push "\"#{attribute}\" must be greater than #{target}" if value <= target
          end
        end

        record.errors.add(attribute, errors)

        errors.empty?
      end

      private def verifies?(option)
        options.has_key?(option) && options[option]
      end
    end
  end
end