class TransactionsController < ApplicationController
  before_filter :mustbeloggedintoview
  
  def mustbeloggedintoview
    unless (signed_in?)
      flash[:error] = "You must be logged in"
      redirect_to root
    end
  end
  
  def new
    @posting = Posting.find_by_id(params[:posting])
    @post_author = User.find_by_id(@posting.user_id)
    
    @transaction = Transaction.new
    @transaction.requestor_id = current_user.id
    @transaction.poster_id = @posting.user_id
    @transaction.item_id = @posting.id
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    
    @transaction = Transaction.new(params[:transaction])
    #@message.sender = @message
    #@message.recipient = Message.find_by_login(params[:message][:to])

    if @transaction.save
      flash[:notice] = "Message sent"
      redirect_to transactions_path
    else
      render :action => :new
    end
  end
  
  def index
    @requesteditems = Transaction.find_all_by_requestor_id(current_user.id)
    
    @posteditems = Transaction.find_all_by_poster_id(current_user.id)
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def show
    
  end
  
  def update
    @transaction = Transaction.find(params[:id])
    flash[:info] = params.inspect.to_s
    if(params[:commit] == "This item has been picked up")
      @transaction.approved_by_poster_at = Time.now()  
    else
      @transaction.approved_by_poster_at = ""   
    end

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to(transactions_path, :notice => 'Transaction was successfully updated.') }
        format.xml  { head :ok }
      else
        flash[:error] = "error" +  @transaction.errors.full_messages
        format.html { redirect_to(transactions_path ) }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
    
  end

end
