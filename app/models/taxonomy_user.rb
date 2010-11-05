class TaxonomyUser < ActiveRecord::Base
  using_access_control
  
  belongs_to :taxonomy
  belongs_to :user
  validates_presence_of :user, :taxonomy
  validates_associated :user, :taxonomy
end
