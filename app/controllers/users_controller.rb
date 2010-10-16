class UsersController < ApplicationController
  before_filter :filterEditPermissions, :only => [:edit,:update]
  
  def filterEditPermissions
    unless(canUserEditCurrentUser?)
      redirect_to users_path
    end
  end
  
  def canUserEditCurrentUser?
    if(current_user.present?)
      if(current_user.is_moderator)
        return true
      else
        return current_user.id == params[:id].to_i
      end
    end
    return false
  end
  
  def new
    
  end
  
  def create
    redirect_to :controller => "sessions",:action=>"create"
  end

  # GET /users
  # GET /users.xml
  def index
    @title = 'User Directory'
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
      bSave = @user.update_attribute(:name,params[:user][:name])
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
