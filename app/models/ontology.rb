class Ontology < ActiveRecord::Base
  belongs_to :language
  has_many :collection_ontologies
	  has_many :collections, :through => :collection_ontologies
  has_many :ontology_users
	  has_many :users, :through => :ontology_users
  has_many :categories
  # Note: the following commented-out "has-many" lines were an attempt to do a self-reference.
  # This was not successful, and was replaced by defining @Translations in the controller.
  has_many :translations, :source => :ontology, :foreign_key => 'translation_id'
      # :class_name => "Translation", 
  using_access_control

  validates_presence_of     :language_id
end