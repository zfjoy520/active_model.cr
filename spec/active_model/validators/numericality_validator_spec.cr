require "../../spec_helper"

def validator
  ActiveModel::Validators::NumericalityValidator.new
end

describe ActiveModel::Validators::PresenceValidator do
  describe "#validate" do
    context "invalid value" do
      it "returns false for classes that aren't a child of Number" do
        validator.validate(new_person, :name, "123").should be_false
      end

      it "adds error message" do
        person = new_person
        validator.validate(person, :age, "invalid")
        person.errors.messages.has_key?(:age).should be_true
        person.errors.messages[:age].first.should eq("\"age\" is not a number")
      end
    end

    context "valid value" do
      it "returns true for a Number instance" do
        validator.validate(new_person, :name, 123).should be_true
      end
    end
  end
end