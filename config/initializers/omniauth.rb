
require 'omniauth'

Rails.application.config.middleware.use Rack::Session::Cookie # OmniAuth requires sessions.
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "rnwrrBWWzqFDJ2HbIxXU8A", "OTDHlKzxFcxqU0rRYFEzVZQIe5EWpZJbufcluBjqiQ"
  #provider :facebook, "APP_ID", "APP_SECRET"
end