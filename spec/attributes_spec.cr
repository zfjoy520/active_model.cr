require "./spec_helper"

describe ActiveModel do
  describe "#attributes" do
    it "returns a hash of the attrinutes with their values" do
      p = Person.new
      p.name = "Alan"
      p.age = 26
      p.attributes.should eq({
        name: "Alan",
        age: 26
      })
    end
  end
end