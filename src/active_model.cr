require "./active_model/*"
require "./active_model/validators/*"

module ActiveModel
  macro included
    include Attributes
    include Validation
  end
end