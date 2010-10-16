# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user_admin?

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :get_subtemplate_and_title
  
  protected
  def get_subtemplate_and_title
    @bodylayout ||= 'interior'
    @title ||= controller_name.capitalize
  end
  
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  
  def current_user_admin?
    return @current_user.is_moderator
  end
  
  def signed_in?
    !!current_user
  end
  
  helper_method :current_user, :signed_in?
  
  def current_user=(user)
    @current_user = user
    if(user.present?)
      session[:user_id] = user.id
    else
      session[:user_id] = nil
    end
  end
  
  
end
