require "../../spec_helper"

def new_validator(options = {} of Symbol => Bool | Int8 | Int16 | Int32 | Int64 | UInt8 | UInt16 | UInt32 | UInt64 | Float32 | Float64)
  ActiveModel::Validators::NumericalityValidator.new(options)
end

describe ActiveModel::Validators::PresenceValidator do
  describe "#validate" do
    context "without options" do
      it "returns true for a Number instance" do
        new_validator.validate(new_person, :age, 123).should be_true
      end

      it "returns false for classes that aren't a child of Number" do
        new_validator.validate(new_person, :age, "123").should be_false
      end

      it "adds error message for invalid values" do
        person = new_person
        new_validator.validate(person, :age, "invalid")
        person.errors.messages.has_key?(:age).should be_true
        person.errors.messages[:age].first.should eq("\"age\" is not a number")
      end
    end

    context "only integer" do
      it "returns true for an Int instance" do
        validator = new_validator({only_integer: true})
        validator.validate(new_person, :age, 123).should be_true
      end

      it "returns false for classes that aren't a child of Int" do
        validator = new_validator({only_integer: true})
        validator.validate(new_person, :age, 93.418).should be_false
      end

      it "adds error message for invalid values" do
        person = new_person
        validator = new_validator({only_integer: true})
        validator.validate(person, :age, 93.418)
        person.errors.messages.has_key?(:age).should be_true
        person.errors.messages[:age].first.should eq("\"age\" must be an integer")
      end
    end

    context "greater than" do
      it "returns true for numbers greater than target" do
        validator = new_validator({greater_than: 10})
        validator.validate(new_person, :age, 11).should be_true
      end

      it "returns false for numbers lesser than target" do
        validator = new_validator({greater_than: 10})
        validator.validate(new_person, :age, 9).should be_false
      end

      it "returns false for numbers equal to target" do
        validator = new_validator({greater_than: 10})
        validator.validate(new_person, :age, 10).should be_false
      end

      it "adds error message for invalid values" do
        person = new_person
        validator = new_validator({greater_than: 10})
        validator.validate(person, :age, 9)
        person.errors.messages.has_key?(:age).should be_true
        person.errors.messages[:age].first.should eq("\"age\" must be greater than 10")
      end
    end

    context "greater than or equal to" do
      it "returns true for numbers greater than target" do
        validator = new_validator({greater_than_or_equal_to: 10})
        validator.validate(new_person, :age, 11).should be_true
      end

      it "returns false for numbers lesser than target" do
        validator = new_validator({greater_than_or_equal_to: 10})
        validator.validate(new_person, :age, 9).should be_false
      end

      it "returns true for numbers equal to target" do
        validator = new_validator({greater_than_or_equal_to: 10})
        validator.validate(new_person, :age, 10).should be_true
      end

      it "adds error message for invalid values" do
        person = new_person
        validator = new_validator({greater_than_or_equal_to: 10})
        validator.validate(person, :age, 9)
        person.errors.messages.has_key?(:age).should be_true
        person.errors.messages[:age].first.should eq("\"age\" must be greater than or equal to 10")
      end
    end

    context "equal to" do
      it "returns false for numbers greater than target" do
        validator = new_validator({equal_to: 10})
        validator.validate(new_person, :age, 11).should be_false
      end

      it "returns false for numbers lesser than target" do
        validator = new_validator({equal_to: 10})
        validator.validate(new_person, :age, 9).should be_false
      end

      it "returns true for numbers equal to target" do
        validator = new_validator({equal_to: 10})
        validator.validate(new_person, :age, 10).should be_true
      end

      it "adds error message for invalid values" do
        person = new_person
        validator = new_validator({equal_to: 10})
        validator.validate(person, :age, 9)
        person.errors.messages.has_key?(:age).should be_true
        person.errors.messages[:age].first.should eq("\"age\" must be equal to 10")
      end
    end

    context "other than" do
      it "returns true for numbers greater than target" do
        validator = new_validator({other_than: 10})
        validator.validate(new_person, :age, 11).should be_true
      end

      it "returns true for numbers lesser than target" do
        validator = new_validator({other_than: 10})
        validator.validate(new_person, :age, 9).should be_true
      end

      it "returns false for numbers equal to target" do
        validator = new_validator({other_than: 10})
        validator.validate(new_person, :age, 10).should be_false
      end

      it "adds error message for invalid values" do
        person = new_person
        validator = new_validator({other_than: 10})
        validator.validate(person, :age, 10)
        person.errors.messages.has_key?(:age).should be_true
        person.errors.messages[:age].first.should eq("\"age\" must be other than 10")
      end
    end

    context "less than" do
      it "returns false for numbers greater than target" do
        validator = new_validator({less_than: 10})
        validator.validate(new_person, :age, 11).should be_false
      end

      it "returns true for numbers less than target" do
        validator = new_validator({less_than: 10})
        validator.validate(new_person, :age, 9).should be_true
      end

      it "returns false for numbers equal to target" do
        validator = new_validator({less_than: 10})
        validator.validate(new_person, :age, 10).should be_false
      end

      it "adds error message for invalid values" do
        person = new_person
        validator = new_validator({less_than: 10})
        validator.validate(person, :age, 11)
        person.errors.messages.has_key?(:age).should be_true
        person.errors.messages[:age].first.should eq("\"age\" must be less than 10")
      end
    end

    context "less than or equal to" do
      it "returns false for numbers greater than target" do
        validator = new_validator({less_than_or_equal_to: 10})
        validator.validate(new_person, :age, 11).should be_false
      end

      it "returns true for numbers less than target" do
        validator = new_validator({less_than_or_equal_to: 10})
        validator.validate(new_person, :age, 9).should be_true
      end

      it "returns false for numbers equal to target" do
        validator = new_validator({less_than_or_equal_to: 10})
        validator.validate(new_person, :age, 10).should be_true
      end

      it "adds error message for invalid values" do
        person = new_person
        validator = new_validator({less_than_or_equal_to: 10})
        validator.validate(person, :age, 11)
        person.errors.messages.has_key?(:age).should be_true
        person.errors.messages[:age].first.should eq("\"age\" must be less than or equal to 10")
      end
    end

    context "odd" do
      it "returns true for odd numbers" do
        validator = new_validator({odd: true})
        validator.validate(new_person, :age, 1).should be_true
      end

      it "returns false for even numbers" do
        validator = new_validator({odd: true})
        validator.validate(new_person, :age, 2).should be_false
      end

      it "adds error message for invalid values" do
        person = new_person
        validator = new_validator({odd: true})
        validator.validate(person, :age, 2)
        person.errors.messages.has_key?(:age).should be_true
        person.errors.messages[:age].first.should eq("\"age\" must be odd")
      end
    end

    context "even" do
      it "returns false for odd numbers" do
        validator = new_validator({even: true})
        validator.validate(new_person, :age, 1).should be_false
      end

      it "returns true for even numbers" do
        validator = new_validator({even: true})
        validator.validate(new_person, :age, 2).should be_true
      end

      it "adds error message for invalid values" do
        person = new_person
        validator = new_validator({even: true})
        validator.validate(person, :age, 1)
        person.errors.messages.has_key?(:age).should be_true
        person.errors.messages[:age].first.should eq("\"age\" must be even")
      end
    end
  end
end