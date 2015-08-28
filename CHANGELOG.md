# Changelog
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## Unreleased
Nothing yet!

## 0.0.1 - 2015-08-28
### Added
- `PresenceValidator`: checks if a string or value is empty.
- `erros` method that return an `Errors` object containing a list of error
  messages assigned to each attribute.
- `valid?` method that perform validations and add errors.
- `validates` method to assign validation rules to one or more attributes.
- `validators` returns a `Hash` where the key are attributes with validators
  assigned to them, and the value is an `Array` of the validators themselves.
- `reset_validators` remove all validators assigned to the class.
- `attributes` method returning a `Hash` with all instance variables and their
  values.