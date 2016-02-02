class ChatsController < ApplicationController

  def index
    @chats = current_user.chat_users.map {|cu| cu.chat }
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
  end

end
