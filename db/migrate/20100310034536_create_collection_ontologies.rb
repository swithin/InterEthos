class CreateCollectionOntologies < ActiveRecord::Migration
  def self.up
    create_table :collection_ontologies do |t|
      t.references :collection
      t.references :ontology
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :collection_ontologies
  end
end
