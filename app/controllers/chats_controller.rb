class ChatsController < ApplicationController

  def index
    chats = current_user.chat_users.map {|cu| cu.chat }
    @chats = chats.sort_by do |chat|
      (chat.messages.last.updated_at if !chat.messages.empty?) || chat.updated_at
    end.reverse!
  end

  def new
    @receiver = User.find(request.env["HTTP_REFERER"].split("/")[4])
    if @chat = current_user.chats.where(personal: true).find {|chat|chat.users.include?(@receiver)}
      @message = Message.new
      respond_to do |format|
        format.js {}
        format.html {redirect_to chat_path(@chat)}
      end
    else
      @chat = Chat.new
      @chat.name = "Private Chat between #{@receiver.name} & #{current_user.name}"
      @chat.personal = true
      @chat.save
      @chat.users << [@receiver, current_user]
      @message = Message.new
      respond_to do |format|
        format.js {}
        format.html {redirect_to chat_path(@chat)}
      end
    end
  end


  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    cu = ChatUser.find_by(chat: @chat, user: current_user)
    cu.view! if cu.unread?
    respond_to do |format|
      format.js{}
      format.html{}
    end
  end

  def read
    cu = ChatUser.find_by(chat: params[:chat_id], user: current_user)
    cu.view! if cu.unread?
    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end

end
