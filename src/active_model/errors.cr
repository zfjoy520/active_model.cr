module ActiveModel
  class Errors
    include Enumerable(String)
    getter :messages

    def initialize
      @messages = {} of Symbol => Array(String)
    end

    def each
      @messages.each do |attribute, messages|
        messages.each do |message|
          yield attribute, message
        end
      end
    end

    def add(attribute : Symbol, message : String)
      @messages[attribute] ||= [] of String
      @messages[attribute].push message
    end

    def add(attribute : Symbol, messages : Array(String))
      messages.each do | message|
        add(attribute, message)
      end
    end

    def clear
      @messages = {} of Symbol => Array(String)
    end

    def blank?
      empty?
    end

    def empty?
      @messages.empty?
    end
  end
end