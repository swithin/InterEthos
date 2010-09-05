class Category < ActiveRecord::Base
  belongs_to :ontology
  
  belongs_to :user
  
  has_many :category_collections, :autosave => true
	  has_many :collections, :through => :category_collections
      accepts_nested_attributes_for :category_collections, :allow_destroy => true, :reject_if => :all_blank

  has_many :translations, :source => :category, :foreign_key => 'translation_id'
      #, :class_name => "Translation",
      
  has_many :relationships
    has_many :synonyms, :through => :relationships

  has_many :inverse_relationships, :class_name => "Relationship", :foreign_key => "synonym_id"
  has_many :inverse_synonyms, :through => :inverse_relationships, :source => :category
    acts_as_tree :order => "name"
end