class MessagesController < ApplicationController

  def create
    binding.pry
    @message = Message.new(sender_id: current_user.id, chat_id: params[:chat_id].to_i, content: params[:message][:content])
    if @message.save
      redirect_to chat_path(@message.chat)
    else
      render chat_path(@message.chat)
    end
  end
end
