class MessagesController < ApplicationController

  def create
    @message = Message.new(sender_id: current_user.id, chat_id: params[:chat_id].to_i, content: params[:message][:content])
    @chat = Chat.find(params[:chat_id])
    if @message.save
      other_users = @message.chat.chat_users.where.not(user: current_user)
      other_users.update_all(aasm_state: "unread")
      respond_to do |format|
        format.js {}
        format.html{redirect_to chat_path(@chat)}
      end
    else
      render chat_path(@message.chat)
    end
  end
end
