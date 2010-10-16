
require 'omniauth'
require 'openid/store/filesystem'
Rails.application.config.middleware.use Rack::Session::Cookie # OmniAuth requires sessions.
#Rails.application.config.middleware.use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp')
#Rails.application.config.middleware.use OmniAuth::Strategies::GoogleApps, OpenID::Store::Filesystem.new('/tmp')
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "rnwrrBWWzqFDJ2HbIxXU8A", "OTDHlKzxFcxqU0rRYFEzVZQIe5EWpZJbufcluBjqiQ"
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
  #provider :facebook, "APP_ID", "APP_SECRET"
end