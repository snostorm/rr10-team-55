# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user_admin?

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :current_user
  before_filter :get_subtemplate_and_title
  before_filter :lookup_ip_location
  
  protected
  def get_subtemplate_and_title
    @bodylayout ||= 'interior'
    @title ||= controller_name.capitalize
  end
  
  # TODO make this a proper application-level singleton
  @@ip_location_fetcher = nil

  def lookup_ip_location
    unless @location
      unless @@ip_location_fetcher
        puts "Creating new IPLocationFetcher" # TODO: remove this debugging/tracing output
        @@ip_location_fetcher = IPLocationFetcher.new
      end

      @current_ip_location = @@ip_location_fetcher.fetch_location(request.remote_ip)
      # lookup existing location record in the DB using ip location
      if @current_ip_location
        # TODO handle when ip_location isn't found in Locations - adding? alternative lookups (name vs. code for prov, country, etc.)
        @location = Location.where('city = ? AND prov_or_state = ?',
                        @current_ip_location.city, @current_ip_location.prov_state.upcase).first
        unless @location
          # Hard code a default
          # TODO: better handling, lookup, choose from list, etc.
          @location = Location.where('city = ? AND prov_or_state = ?',
                          'Edmonton', 'AB').first
        end

        if @location
          if @current_user
            puts "Setting location " + @location.to_s + " for user " + @current_user.name
            @current_user.location = @location
          else
            puts "No current user."
          end
        else
          # TODO add IP location to Locations table?
          # TODO IP lookup returns country as name, usually, so may have to lookup by name or 2 letter code
        end
      end
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
    if @current_user
      @location ||= @current_user.location
    end
    return @current_user
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
