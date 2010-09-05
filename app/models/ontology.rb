class Ontology < ActiveRecord::Base
  has_many :categories

  belongs_to :language

  has_many :internationalizations, :source => :ontology
      #, :foreign_key => 'internationalization_id', :class_name => "Internationalizations", 

  has_many :ontology_users
	  has_many :users, :through => :ontology_users

  using_access_control

  validates_presence_of :language_id
end