module ActiveModel
  module Attributes
    macro def attributes() : Hash(Symbol, String | Int32 | Nil)
      values = {} of Symbol => String | Int32 | Nil
      {% for instance_var in @type.instance_vars %}
      {% unless instance_var.id.ends_with?("errors") && instance_var.id.length == "errors".length %}
      values[:"{{ instance_var.id }}"] = @{{ instance_var.id }}
      {% end %}
      {% end %}
      values
    end
  end
end