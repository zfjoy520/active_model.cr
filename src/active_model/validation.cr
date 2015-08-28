module ActiveModel
  module Validation
    macro included
      def self.validates(attribute : Symbol, validations : Hash)
        if validations.empty?
          raise ArgumentError.new("You must inform at least one validation rule")
        end
        validations.each do |name, value|
          add_validator(attribute, name)
        end
      end

      def self.validators
        @@validators ||= {} of Symbol => Array(Validators::AbstractValidator)
      end

      def self.reset_validators
        @@validators = {} of Symbol => Array(Validators::AbstractValidator)
      end

      private def self.add_validator(attribute : Symbol, validator_name : Symbol)
        unless validators.has_key?(attribute)
          validators[attribute] = [] of Validators::AbstractValidator
        end
        validator_class = get_validator_class(validator_name)
        validators[attribute].push validator_class.new
      end

      private def self.get_validator_class(name : Symbol)
        case name
        when :presence
          Validators::PresenceValidator
        else
          raise ArgumentError.new("Invalid validator \"#{name}\"")
        end
      end
    end

    def errors
      @errors ||= Errors.new
    end

    def valid?
      errors.clear
      validate
      errors.blank?
    end

    def validate
      self.class.validators.each do |attribute, validators|
        validators.each do |validator|
          validate_with(attribute, validator)
        end
      end
    end

    private def validate_with(attribute : Symbol, validator : Validators::AbstractValidator)
      validator.validate(self, attribute, self.attributes[attribute])
    end
  end
end