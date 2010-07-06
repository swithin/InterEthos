class CategoryCollection < ActiveRecord::Base
  using_access_control
  
  belongs_to :category
  belongs_to :collection
  validates_presence_of :category, :collection
  validates_associated :category, :collection
end
