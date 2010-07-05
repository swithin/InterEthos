class CollectionOntology < ActiveRecord::Base
  belongs_to :collection
  belongs_to :ontology
end
