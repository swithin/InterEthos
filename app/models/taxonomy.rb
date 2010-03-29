class Taxonomy < ActiveRecord::Base
  belongs_to :language
  has_and_belongs_to_many :collections
  has_and_belongs_to_many :users

  validates_presence_of     :language_id
end
