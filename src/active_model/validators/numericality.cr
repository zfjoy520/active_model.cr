module ActiveModel
  module Validators
    class NumericalityValidator < AbstractValidator
      def validate(record, attribute, value)
        errors = [] of String

        if value.is_a?(Number)
          if verifies?(:only_integer) && !value.is_a?(Int)
            errors.push "\"#{attribute}\" must be an integer"
          end

          if compares?(:greater_than)
            target = get_comparation_option(:greater_than)
            errors.push "\"#{attribute}\" must be greater than #{target}" if value <= target
          end

          if compares?(:greater_than_or_equal_to)
            target = get_comparation_option(:greater_than_or_equal_to)
            errors.push "\"#{attribute}\" must be greater than or equal to #{target}" if value < target
          end

          if compares?(:equal_to)
            target = get_comparation_option(:equal_to)
            errors.push "\"#{attribute}\" must be equal to #{target}" if value != target
          end

          if compares?(:other_than)
            target = get_comparation_option(:other_than)
            errors.push "\"#{attribute}\" must be other than #{target}" if value == target
          end

          if compares?(:less_than)
            target = get_comparation_option(:less_than)
            errors.push "\"#{attribute}\" must be less than #{target}" if value >= target
          end

          if compares?(:less_than_or_equal_to)
            target = get_comparation_option(:less_than_or_equal_to)
            errors.push "\"#{attribute}\" must be less than or equal to #{target}" if value > target
          end

          if verifies?(:odd)
            errors.push "\"#{attribute}\" must be odd" if (value % 2 == 0)
          end

          if verifies?(:even)
            errors.push "\"#{attribute}\" must be even" unless (value % 2 == 0)
          end
        else
          errors.push "\"#{attribute}\" is not a number"
        end

        record.errors.add(attribute, errors)

        errors.empty?
      end

      private def verifies?(option)
        options.has_key?(option) && options[option]
      end

      private def compares?(comparation_option)
        verifies?(comparation_option) && options[comparation_option].is_a?(Number)
      end

      private def get_comparation_option(name)
        options[name].to_s.to_f # required because of compilation errors
      end
    end
  end
end