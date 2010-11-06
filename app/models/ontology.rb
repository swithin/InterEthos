class Ontology < ActiveRecord::Base
  
  # * * * * * * * * * * *
  # * * * * * * * * * * *
  # * * * * * * * * * * *
  # PLEASE LEAVE THIS FILE
  # Yes it is not needed, as "Ontologies" were replaced with "Taxonomies",
  # but it lets a dataload migration run on the full db/migrate of GitHub repository installations
  # * * * * * * * * * * *
  # * * * * * * * * * * *
  # * * * * * * * * * * *
  
  has_many :categories

  belongs_to :language

  has_many :internationalizations, :source => :ontology, :order => ':name'
      #, :foreign_key => 'internationalization_id', :class_name => "Internationalizations", 

  has_many :ontology_users
	  has_many :users, :through => :ontology_users

  using_access_control

  validates_presence_of :language_id
end