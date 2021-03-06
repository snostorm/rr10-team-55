# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user_admin?,:current_user, :signed_in?

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
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
    if(!session[:user_id].present?)
      return
    end
    debugger
    logger.info("lookup_ip_location")
    unless @location
      unless @@ip_location_fetcher
        logger.info "Creating new IPLocationFetcher"
        @@ip_location_fetcher = IPLocationFetcher.new
        @@ip_location_fetcher.initialize_ip
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
          @location = Location.find(1)
        end

        if @location
          if @current_user
            logger.info "Setting location #{@location.city}, #{@location.prov_or_state} for user #{@current_user.name}"
            @current_user.location = @location
          else
            logger.info "No current user."
          end
        else
          # TODO add IP location to Locations table?
          # TODO IP lookup returns country as name, usually, so may have to lookup by name or 2 letter code
        end
      end
    end
  end

  def current_user
    logger.info("current_user: session id: " + session[:user_id].to_s)
    if(session[:user_id].present?)
      @current_user ||= User.find_by_id(session[:user_id])
      logger.info("current user " + @current_user.inspect)
      if @current_user.present?
        logger.info("current user present")
        @location ||= @current_user.location
      end
      return @current_user
    else
      return nil
    end
  end
  
  def current_user_admin?
    return @current_user.is_moderator
  end
  
  def signed_in?
    if(session[:user_id].present?)
      logger.info("signed_in?")
      !!current_user
    else
      return nil
    end
  end
  
  def current_user=(user)
    @current_user = user
    if(user.present?)
      session[:user_id] = user.id
    else
      session[:user_id] = nil
    end
  end
  
  
end
