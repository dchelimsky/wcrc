# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_storytracker_session',
  :secret      => '116d36ce26de41091c2de38e0b30070d8a6ebbde634d56fbe930f07f110912874d2ed60f08cee9c789557989ab27d94cee204a6f724cc300fc48c524223ca10c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
