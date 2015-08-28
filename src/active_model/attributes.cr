module ActiveModel
  module Attributes
    macro def attributes() : Hash(Symbol, String | Bool | Int8 | Int16 | Int32 | Int64 | UInt8 | UInt16 | UInt32 | UInt64 | Float32 | Float64 | Nil)
      values = {} of Symbol => String | Bool | Int8 | Int16 | Int32 | Int64 | UInt8 | UInt16 | UInt32 | UInt64 | Float32 | Float64 | Nil
      {% for instance_var in @type.instance_vars %}
      {% unless instance_var.id.ends_with?("errors") && instance_var.id.length == "errors".length %}
      values[:"{{ instance_var.id }}"] = @{{ instance_var.id }}
      {% end %}
      {% end %}
      values
    end
  end
end