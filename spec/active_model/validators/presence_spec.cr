require "../../spec_helper"

def validator
  ActiveModel::Validators::PresenceValidator.new
end

describe ActiveModel::Validators::PresenceValidator do
  describe "#validate" do
    context "invalid value" do
      it "returns false for empty string" do
        validator.validate(new_person, :name, "").should be_false
      end

      it "returns false for nil" do
        validator.validate(new_person, :name, nil).should be_false
      end

      it "adds error message" do
        person = new_person
        validator.validate(person, :name, "")
        person.errors.messages.has_key?(:name).should be_true
        person.errors.messages[:name].first.should eq("\"name\" can't be blank")
      end
    end

    context "valid value" do
      it "returns true for non-empty string" do
        validator.validate(new_person, :name, "Something").should be_true
      end

      it "returns true for true" do
        validator.validate(new_person, :name, true).should be_true
      end

      it "returns true for false" do
        validator.validate(new_person, :name, false).should be_true
      end
    end
  end
end