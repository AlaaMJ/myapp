class MessagesController < ApplicationController
  def index
    @messages=Message.all
  end

  def sent
    @messages=Message.all
  end
  
  def show
    @message = Message.find(params[:id])
    
  end

  def delete
    @message.destroy
    redirect_to message_url
  end

  def new
  	@message = Message.new
    if (session[:reciever_id])
      @message.reciever_id = session[:reciever_id]
    end  
  end
end
