class CollectionsOntology < ActiveRecord::Base
  belongs_to :collection
  belongs_to :ontology
end
