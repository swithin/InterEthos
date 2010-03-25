# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_interethos_session',
  :secret      => '5c822c0f57db8c4fd4e28a18be777521ee4e705275fc0f4d670e92f9a4625fb37a47aedf5bdbd7357723714a9b2421396cc9379cb1ad2832090da9d785b1738d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
