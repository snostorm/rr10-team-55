class UsersController < ApplicationController
  
  def new
    
  end
  
  def create
    auth = request.env['rack.auth']
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    # Log the authorizing user in.
    self.current_user = @auth.user
  
    redirect_to edit_user_path
  end

  # GET /users
  # GET /users.xml
  def index
    @users = User.paginate(:page => params[:page], :per_page => User.per_page)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user ||= User.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # PUT /Users/1
  # PUT /Users/1.xml
  def update
    
    @user = User.find(params[:id])
    
    bSave = true
    
    if(bSave)
      bSave = @user.update_attribute(:bio,params[:user][:bio])
    end
    
    if(bSave)
      bSave = @user.update_attribute(:location,params[:user][:location])
    end
    
    if(bSave)
      bSave = @user.update_attribute(:first_name,params[:user][:first_name])
    end
    
    if(bSave)
      bSave = @user.update_attribute(:last_name,params[:user][:last_name])
    end
    
    if(bSave)
      bSave = @user.update_attribute(:email,params[:user][:email])
      #@user.email = params[:user][:email]
      #bSave = @user.save
    end
    
    #debugger
    respond_to do |format|
      if bSave
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /users/1/edit
  def edit
   @user = User.find(params[:id])   
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_path) }
      format.xml  { head :ok }
    end
  end
end
