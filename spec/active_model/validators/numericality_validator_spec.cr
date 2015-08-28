require "../../spec_helper"

def numeric_validator
  ActiveModel::Validators::NumericalityValidator.new
end

def integer_validator
  ActiveModel::Validators::NumericalityValidator.new({only_integer: true})
end

describe ActiveModel::Validators::PresenceValidator do
  describe "#validate" do
    context "without options" do
      it "returns true for a Number instance" do
        numeric_validator.validate(new_person, :name, 123).should be_true
      end

      it "returns false for classes that aren't a child of Number" do
        numeric_validator.validate(new_person, :name, "123").should be_false
      end

      it "adds error message for non-numeric values" do
        person = new_person
        numeric_validator.validate(person, :age, "invalid")
        person.errors.messages.has_key?(:age).should be_true
        person.errors.messages[:age].first.should eq("\"age\" is not a number")
      end
    end

    context "integer only" do
      it "returns true for an Int instance" do
        integer_validator.validate(new_person, :name, 123).should be_true
      end

      it "returns false for classes that aren't a child of Int" do
        integer_validator.validate(new_person, :name, 93.418).should be_false
      end

      it "adds error message for non-integer values" do
        person = new_person
        integer_validator.validate(person, :age, 93.418)
        person.errors.messages.has_key?(:age).should be_true
        person.errors.messages[:age].first.should eq("\"age\" must be an integer")
      end
    end
  end
end