class CollectionUser < ActiveRecord::Base
  using_access_control
  
  belongs_to :collection
  belongs_to :user
  validates_presence_of :user, :collection
  validates_associated :user, :collection
end