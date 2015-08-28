require "../spec_helper"

describe ActiveModel::Validation do
  describe ".validates" do
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

    context "with one attribute name" do
      it "adds a validator to the attribute" do
        Person.validates :age, { presence: true }
        Person.validators.has_key?(:age).should be_true
        Person.validators[:age].should be_a(Array)
        Person.validators[:age].first.should be_a(ActiveModel::Validators::PresenceValidator)
      end
    end

    context "with a list of attribute names" do
      it "adds a validator to each attribute" do
        Person.reset_validators
        Person.validates [:age, :name], { presence: true }
        Person.validators.has_key?(:age).should be_true
        Person.validators.has_key?(:name).should be_true
        Person.validators[:age].should be_a(Array)
        Person.validators[:name].should be_a(Array)
        Person.validators[:age].first.should be_a(ActiveModel::Validators::PresenceValidator)
        Person.validators[:name].first.should be_a(ActiveModel::Validators::PresenceValidator)
      end
    end
  end

  describe ".reset_validators" do
    it "removes all validators associated with the class" do
      Person.validates :age, { presence: true }
      Person.validates :name, { presence: true }
      Person.reset_validators
      Person.validators.should eq({} of Symbol => Array(ActiveModel::Validators::AbstractValidator))
    end
  end

  describe "#errors" do
    it "returns an instance of ActiveModel::Errors" do
      person = Person.new
      person.errors.should be_a(ActiveModel::Errors)
    end
  end

  describe "#valid?" do
    context "without validation rules" do
      it "returns always true" do
        new_person.valid?.should be_true
      end
    end

    context "with valid attributes" do
      it "returns true" do
        Person.validates :age, { presence: true }
        person = Person.new
        person.age = 26
        person.valid?.should be_true
      end

      context "after uncessful validation" do
        it "returns true" do
          Person.validates :age, { presence: true }
          person = Person.new
          person.age = nil
          person.valid?.should be_false
          person.age = 26
          person.valid?.should be_true
        end
      end
    end

    context "with invalid attributes" do
      it "returns false" do
        Person.validates :age, { presence: true }
        person = Person.new
        person.age = nil
        person.valid?.should be_false
      end

      it "adds error messages" do
        Person.reset_validators
        Person.validates :age, { presence: true }
        person = Person.new
        person.age = nil
        person.valid?.should be_false
        person.errors.messages.should eq({age: ["\"age\" can't be blank"]})
      end
    end
  end
end