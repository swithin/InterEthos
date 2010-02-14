# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sharedtaxonomy_session',
  :secret      => 'd7f2c4b635ab7e96ded4c619919dd1fb80792535f76fea3c24bc7c5ae759a47cfc0080a1f116939f62d645daf968db62885a9debfe3271bc0d5c699998604f66'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
