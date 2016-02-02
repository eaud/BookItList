class ChatsController < ApplicationController

  def index
    @chats = current_user.chat_users.map {|cu| cu.chat }
  end

  def new
    @chat = Chat.new
    @receiver = User.find(request.env["HTTP_REFERER"].split("/")[4])
    @chat.name = "Private Chat between #{@receiver.name} & #{current_user.name}"
    @chat.save
    @chat.users << [@receiver, current_user]
    @message = Message.new
    redirect_to chat_path(@chat)
  end


  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    cu = ChatUser.find_by(chat: @chat, user: current_user)
    cu.view! if cu.aasm_state == "unread"
  end

end
