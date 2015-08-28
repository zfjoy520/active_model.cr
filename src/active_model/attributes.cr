module ActiveModel
  module Attributes
    macro def attributes() : Hash(Symbol, String | Int32 | Nil)
      values = {} of Symbol => String | Int32 | Nil
      {% for instance_var in @type.instance_vars %}
      values[:"{{instance_var}}"] = @{{ instance_var }}
      {% end %}
      values
    end
  end
end