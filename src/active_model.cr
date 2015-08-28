require "./active_model/*"
require "./active_model/validators/*"

module ActiveModel
  macro included
    include Attributes
    include Errors
    include Validation
  end
end