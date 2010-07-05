class TeamUser < ActiveRecord::Base
  using_access_control

  belongs_to :team
  belongs_to :user
  validates_presence_of :user, :team
  validates_associated :user, :team
end