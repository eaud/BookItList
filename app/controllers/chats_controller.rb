class ChatsController < ApplicationController

  def index
    @chats = current_user.chat_users.map {|cu| cu.chat }
  end

  def new
    @chat = Chat.new
    @message = message.new
  end

  def create
    
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    cu = ChatUser.find_by(chat: @chat, user: current_user)
    cu.view! if cu.aasm_state == "unread"
  end

end
