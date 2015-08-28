module ActiveModel
  module Errors
    def errors
      @errors ||= {} of Symbol => Array(String)
    end

    def add_error(attribute : Symbol, message : String)
      errors[attribute] ||= [] of String
      errors[attribute].push message
    end

    def add_errors(attribute : Symbol, messages : Array(String))
      messages.each do | message|
        add_error(attribute, message)
      end
    end

    def clear_errors
      @errors = {} of Symbol => Array(String)
    end
  end
end