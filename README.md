# ActiveModel for Crystal

[![Build Status](https://travis-ci.org/alanwillms/active_model.cr.svg)](https://travis-ci.org/alanwillms/active_model.cr)

This library is an adaptation of Ruby on Rails' ActiveModel to Crystal
programming language.

## Installation

Add it to `Projectfile`:

```ruby
deps do
  github "alanwillms/active_model.cr"
end
```

## Usage

```ruby
require "active_model"

class Person
  include ActiveModel

  validates [:name, :age] { presence: true }
  validates :age, { numericality: { only_integer: true } }

  def initialize(@name, @age)
  end
end

person = Person.new
person.valid? # false
person.errors.messages # {:name => ["\"name\" can't be blank"], :age => ["\"age\" can't be blank"]}

person.name = "Alan"
person.age = 26
person.valid? # true

person.attributes # {:name => "Alan", :age => 26}
```

## Validators

ActiveModel comes with a set of built-in validators:

```ruby
class Foo

  # Presence
  validates :name, { presence : true }

  # Numericality
  validates :amount, { numericality : true } # is a number
  validates :amount, { numericality : { only_integer: true } } # is an integer
  validates :amount, { numericality : { greater_than: 0 } } # > other number
  validates :amount, { numericality : { greater_than_or_equal_to: 0 } } # >= other number
  validates :amount, { numericality : { equal_to: 0 } } # == other number
  validates :amount, { numericality : { less_than: 0 } } # < other number
  validates :amount, { numericality : { less_than_or_equal_to: 0 } } # <= other number
  validates :amount, { numericality : { odd: true } } # is odd
  validates :amount, { numericality : { even: true } } # is even
  validates :amount, { numericality : { other_than: 0 } } # != other number

end
```

## Roadmap

* [x] Validation methods: `valid?`, `validates(attribute, rules)`
* [x] Attributes getter: `attributes`
* [x] Add method to obtain error messages: `errors`
* [x] `PresenceValidator`: check if a field is empty
* [ ] Add other validation rules: `number`, `email`, `length`, `url`, etc.
* [ ] Allow custom validators with classes and/or closures
* [ ] Error messages i18n

## Contributing

1. Fork it ( https://github.com/alanwillms/active_model.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [alanwillms](https://github.com/alanwillms) Alan Willms - creator, maintainer
