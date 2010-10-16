class SessionsController < ApplicationController
  def create
    build_auth()
  
    redirect_to user_path(self.current_user)
  end
  
  def create_with_twitter
    auth = request.env['rack.auth']
    
    build_auth()
    
    self.current_user.name = request.env['omniauth.auth']['user_info']['nickname']
    self.current_user.location = request.env['omniauth.auth']['user_info']['location']
    self.current_user.save
  
    redirect_to user_path(self.current_user)
  end
  
  def destory
    self.current_user = nil
    redirect_to root_path
  end
  
protected
  def build_auth
    auth = request.env['rack.auth']
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    # Log the authorizing user in.
    self.current_user = @auth.user
  end
end
