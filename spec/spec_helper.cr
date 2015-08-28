require "spec"
require "../src/*"

def new_person
  Person.new
end

class Person
  include ActiveModel
  getter :name, :age
  setter :name, :age

  def initialize(@name = "Alan", @age = 26)
  end
end