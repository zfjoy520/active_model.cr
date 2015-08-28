require "../../src/*"

class Profile
  include ActiveModel

  validates [:name, :age, :admin], { presence: true }

  def initialize(@name, @age, @admin)
  end
end

describe Profile do
  it "accepts valid attributes" do
    profile = Profile.new("", nil, false)
    profile.valid?.should be_false
  end

  it "accepts invalid attributes" do
    profile = Profile.new("Alan", 26, false)
    profile.valid?.should be_true
  end
end