require "../spec_helper"

def new_error
  ActiveModel::Errors.new
end

describe ActiveModel::Errors do
  describe "#add" do
    context "with string" do
      it "append error to the attribute list of errors" do
        errors = new_error
        errors.add(:name, "My first error")
        errors.add(:age, "My second error")
        errors.add(:age, "My third error")
        errors.messages.should eq({
          name: ["My first error"],
          age: ["My second error", "My third error"]
        })
      end
    end

    context "with array of strings" do
      it "append multiple errors to the attribute list of errors" do
        errors = new_error
        errors.add(:name, "My first error")
        errors.add(:age, ["My second error", "My third error"])
        errors.messages.should eq({
          name: ["My first error"],
          age: ["My second error", "My third error"]
        })
      end
    end
  end

  describe "#clear" do
    it "clear list of errors" do
      errors = new_error
      errors.add(:age, ["My second error", "My third error"])
      errors.clear
      errors.messages.should eq({} of Symbol => Array(String))
    end
  end
end