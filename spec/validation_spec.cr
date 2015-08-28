require "./spec_helper"

describe ActiveModel do
  describe ".validates" do
    it "is accessible" do
      new_person.class.responds_to?(:validates).should be_true
    end

    it "requires at least one validation rule" do
      expect_raises ArgumentError, "You must inform at least one validation rule" do
        Person.validates :tentacles, {} of Symbol => Bool
      end
    end

    it "does not allow invalid validation rules" do
      expect_raises ArgumentError, "Invalid validator \"nonexistent_validator\"" do
        Person.validates :age, { nonexistent_validator: true }
      end
    end

    it "adds a validator to the attribute" do
      Person.validates :age, { presence: true }
      Person.validators.has_key?(:age).should be_true
      Person.validators[:age].should be_a(Array)
      Person.validators[:age].first.should be_a(ActiveModel::Validators::PresenceValidator)
    end
  end

  describe "#valid?" do
    it "is accessible" do
      new_person.responds_to?(:valid?).should be_true
    end

    context "returns true when" do
      it "has no validations" do
        new_person.valid?.should be_true
      end

      it "pass all validations" do
        Person.validates :age, { presence: true }
        person = Person.new
        person.age = 26
        new_person.valid?.should be_true
      end
    end

    context "returns false when" do
      it "fails at any validation" do
        Person.validates :age, { presence: true }
        person = Person.new
        person.age = nil
        person.valid?.should be_false
      end
    end
  end
end