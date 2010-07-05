class Collection < ActiveRecord::Base
  # Activate model authorization by calling using_access_control.
  # Every create, update, destroy will be checked and an exception raised
  # if not allowed.  For performance reasons, read isn't checked by default,
  # but may be enabled as an option.
  using_access_control
  
  has_many :collection_ontologies
	  has_many :ontologies, :through => :collection_ontologies

  has_many :collection_users, :autosave => true
	  has_many :users, :through => :collection_users
  accepts_nested_attributes_for :collection_users, :allow_destroy => true, :reject_if => :all_blank
  # The above "accepts..." is for future functionality where the "Collection" Edit
  # form will update added information in the "collection_users" table.
	
  def is_owned_by? (user)
    not owned_by(user).nil?
  end
  
  def owned_by (user)
    collection_users.find_by_user_id(user)
  end
end
