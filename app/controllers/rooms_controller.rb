class RoomsController < ApplicationController
  include ActionController::Live
  @@lock = Mutex.new

  def index
    redirect_to room_path(random_room_name)
  end

  def show
  end

  def subscribe
    logger.info "Stream connected: #{channel}"
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream, retry: 300)
    redis.subscribe(channel) do |on|
      on.subscribe do |channel, subscriptions|
        logger.info "Subscribed to #{channel} (#{subscriptions} subscriptions)"
      end
      on.message do |_, message|
        sse.write(message)
      end
    end
  rescue IOError
    logger.info 'Stream closed'
  rescue ActionController::Live::ClientDisconnected
    logger.info 'Client disconnected'
  ensure
    sse.close
  end

  private

  def channel
    params[:room_id]
  end

  def random_room_name
    SecureRandom.hex(4)
  end

  def redis
    # FIXME: 都度インスタンスを作るのは筋が悪い気がする
    Redis.new(REDIS_OPTIONS)
  end
end