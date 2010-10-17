class MessagesController < ApplicationController
  before_filter :mustbeloggedintoview, :only => [:show,:new,:create,:edit,:update]
  
  def new
    @message = Message.new
    
    @posting = Posting.find_by_id(params[:posting])
    @post_author = User.find_by_id(@posting.user_id)

    @message.subject = @posting.title
    @message.recipient_id = @posting.user_id
    @message.sender_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def index
    @title = 'Message Centre'
    
    @users = User.where('email not ?', nil)
    if(signed_in?)
      @messages = Message.all
      @sentmessages = Message.find_all_by_sender_id(current_user.id)
    
      @receivedmessages = Message.find_all_by_recipient_id(current_user.id)
    end 
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def show
    @message = Message.find_by_id(params[:id])
    
    if(@message.recipient_id == current_user.id)
      @message.read_at = Time.now() 
      @message.save
    end
  end
  
  def create
    @message = Message.new(params[:message])
    #@message.sender = @message
    #@message.recipient = Message.find_by_login(params[:message][:to])

    if @message.save
      flash[:notice] = "Message sent"
      redirect_to messages_path
    else
      render :action => :new
    end
  end
  
  def delete_selected
    if request.post?
      if params[:delete]
        params[:delete].each { |id|
          @message = Message.find(:first, :conditions => ["messages.id = ? AND (sender_id = ? OR recipient_id = ?)", id, @message, @message])
          @message.mark_deleted(@message) unless @message.nil?
        }
        flash[:notice] = "Messages deleted"
      end
      redirect_to user_message_path(@message, @messages)
    end
  end
  
  private
    
  
  def mustbeloggedintoview
    unless(signed_in?)
      flash[:error] = "you must be logged in to read or create messages"
      redirect_to messages_path
    end
  end
end