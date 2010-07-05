class CollectionUser < ActiveRecord::Base
  using_access_control
  
  belongs_to :user
  belongs_to :collection
  validates_presence_of :user, :collection
  validates_associated :user, :collection
end
