module Toadbot

  # Override StandardError and message
  class Error < StandardError
    def initialize(obj, msg)
      @object = obj
      @message = msg
    end

    # Override standard error message
    def message
      "[#{@object.underline}] #{@message.red}"
    end
  end
end
