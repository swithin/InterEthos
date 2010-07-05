class OntologiesUser < ActiveRecord::Base
  belongs_to :ontology
  belongs_to :user
end
