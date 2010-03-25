class CollectionsUser < ActiveRecord::Base
  belongs_to :collection
  belongs_to :user
end
