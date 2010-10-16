# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_letitfreeme_session',
  :secret      => 'b023e03523f0e03bb7626c3d861b2ac3ff80b0862216f256d4cbd47f1786b7ee1c56d3746c80921d25bca8a9b906d7136aaebfddab43db1d225ce5df52822251'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
