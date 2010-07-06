class Ontology < ActiveRecord::Base
  belongs_to :language
  has_many :collection_ontologies
	  has_many :collections, :through => :collection_ontologies
  has_many :ontology_users
	  has_many :users, :through => :ontology_users
  has_many :categories
  using_access_control

  validates_presence_of     :language_id
end