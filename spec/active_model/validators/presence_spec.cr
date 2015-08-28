require "../../spec_helper"

def validator
  ActiveModel::Validators::PresenceValidator.new
end

describe ActiveModel::Validators::PresenceValidator do
  describe "#validate" do
    context "returns false if" do
      it "receives empty string" do
        validator.validate(new_person, :name, "").should be_false
      end

      it "receives nil" do
        validator.validate(new_person, :name, nil).should be_false
      end

      it "receives false" do
        validator.validate(new_person, :name, false).should be_false
      end
    end

    context "returns true if" do
      it "receives non-empty string" do
        validator.validate(new_person, :name, "Something").should be_true
      end

      it "receives true" do
        validator.validate(new_person, :name, true).should be_true
      end
    end
  end
end