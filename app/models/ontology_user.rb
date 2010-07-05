class OntologyUser < ActiveRecord::Base
  using_access_control
  
  belongs_to :ontology
  belongs_to :user
  validates_presence_of :user, :ontology
  validates_associated :user, :ontology
end
