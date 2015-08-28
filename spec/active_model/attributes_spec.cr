require "../spec_helper"

describe ActiveModel::Attributes do
  describe "#attributes" do
    it "returns a hash of the attrinutes with their values" do
      person = Person.new
      person.name = "Alan"
      person.age = 26
      person.attributes.should eq({
        name: "Alan",
        age: 26
      })
    end

    it "does not contain an errors attribute" do
      person = Person.new
      person.name = "Alan"
      person.age = 26
      person.attributes.has_key?(:errors).should be_false
    end
  end
end