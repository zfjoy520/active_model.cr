module ActiveModel
  module Validators
    abstract class AbstractValidator
      abstract def validate(record, attribute, value) : Bool
    end
  end
end