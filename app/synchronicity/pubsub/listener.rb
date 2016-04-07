module Synchronicity
  class Listener

    def initialize(topic=nil)
      @topic = topic || 's3pub'
    end

    attr_reader :topic

    def listen
      Propono.listen_to_queue(topic) do |message|
        p message
      end
    end

  end
end
