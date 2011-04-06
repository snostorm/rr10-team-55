class MessagesController < ApplicationController
  before_filter :mustbeloggedintoview
  
  def mustbeloggedintoview
    unless (signed_in?)
      flash[:error] = "You must be logged in"
      redirect_to new_user_path
    end
  end
  
  def new
    @message = Message.new
     
    @posting = Posting.find_by_id(params[:posting])
    @post_author = User.find_by_id(@posting.user_id)
    @recipient = User.find_by_id( params[:recipient_id])
    
    @message.subject = @posting.title
    @message.recipient_id = @recipient.id
    @message.sender_id = current_user.id
    
    respond_to do |format|
       format.html # new.html.erb
    end
  end
  
  def index
    logger.info("messages index action")
    @title = 'Message Centre'
    
    #if(signed_in?)
      @users = User.includes(:sent_messages, :received_messages).where('messages.sender_id = ? OR messages.recipient_id = ?', @current_user.id, @current_user.id)
      @users.all.delete(@current_user)
      
      @sentmessages = @current_user.sent_messages
      @receivedmessages = @current_user.received_messages
      
      @messages = (@sentmessages | @receivedmessages) << Message.new(:subject=>'Welcome!', :body=>'Welcome to letitfree.me!', :created_at=>@current_user.created_at)
      # @messages.sort_by { |o|
      #   o.created_at
      # }
      
      respond_to do |format|
        format.html # new.html.erb
      end
    #else
    #  return redirect_to root_path
    #end
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
    @message.sender = @current_user
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
end