require "../spec_helper"

describe ActiveModel::Errors do
  describe "#errors" do
    it "returns empty hash if there are no errors" do
      person = Person.new
      person.errors.should eq({} of Symbol => Array(String))
    end
  end

  describe "#add_error" do
    it "append error to the attribute list of errors" do
      person = Person.new
      person.add_error(:name, "My first error")
      person.add_error(:age, "My second error")
      person.add_error(:age, "My third error")
      person.errors.should eq({
        name: ["My first error"],
        age: ["My second error", "My third error"]
      })
    end
  end

  describe "#add_errors" do
    it "append multiple errors to the attribute list of errors" do
      person = Person.new
      person.add_error(:name, "My first error")
      person.add_errors(:age, ["My second error", "My third error"])
      person.errors.should eq({
        name: ["My first error"],
        age: ["My second error", "My third error"]
      })
    end
  end

  describe "#clear_errors" do
    it "clear list of errors" do
      person = Person.new
      person.add_errors(:age, ["My second error", "My third error"])
      person.clear_errors
      person.errors.should eq({} of Symbol => Array(String))
    end
  end
end