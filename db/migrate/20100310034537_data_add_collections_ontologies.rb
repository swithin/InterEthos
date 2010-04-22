class DataAddCollectionsOntologies < ActiveRecord::Migration
  def self.up
    Collections_Ontology.load_from_file
  end

  def self.down
    Collections_Ontology.delete_all
  end
end