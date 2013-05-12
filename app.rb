require "goliath"
require "goliath/websocket"

module MissionControl
  Message = Struct.new(:subscription, :data)

  class WebSocket < Goliath::WebSocket
    def on_open(env)
      env.logger.info("Socket open session: #{env["REQUEST_PATH"]}")
      env["subscription"] = env["channel"].subscribe do |message|
        unless env["subscription"] == message.subscription
          env.logger.info("Message from #{message.subscription} to #{env["subscription"]}")
          env.stream_send(message.data)
        end
      end
      env.logger.info("Subscription id: #{env["subscription"]}")
    end

    def on_message(env, msg)
      env.logger.info("New message: #{msg} to session: #{env["REQUEST_PATH"]}")
      env["channel"] << Message.new(env["subscription"], msg)
    end

    def on_close(env)
      env.logger.info("Socket Closed")
      env["channel"].unsubscribe(env["subscription"])
    end

    def on_error(env, error)
      env.logger.error(error)
    end

    def response(env)
      env["channel"] = env.channels[env["REQUEST_PATH"]]

      super(env)
    end
  end
end
