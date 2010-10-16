# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  
  def signed_in?
    !!current_user
  end
  
  helper_method :current_user, :signed_in?
  
  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end
end
