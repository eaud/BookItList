class MessagesController < ApplicationController

  def create
    @message = Message.new(sender_id: current_user.id, chat_id: params[:chat_id].to_i, content: params[:message][:content])
    if @message.save
      other_users = @message.chat.chat_users.where.not(user: current_user)
      other_users.update_all(aasm_state: "unread")
      redirect_to chat_path(@message.chat)
    else
      render chat_path(@message.chat)
    end
  end
end
