class Ontology < ActiveRecord::Base
  belongs_to :language
  has_and_belongs_to_many :collections
  has_and_belongs_to_many :users
  has_many :categories
  using_access_control

  validates_presence_of     :language_id
end
