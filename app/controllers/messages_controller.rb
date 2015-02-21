class MessagesController < ApplicationController
  def create
    message = Message.new(message_params).to_json
    Redis.current.publish(channel, message)
    respond_to do |format|
      format.js { head :created }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :name)
  end

  def channel
    params[:room_id]
  end
end