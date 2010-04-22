class CreateCollectionsOntologies < ActiveRecord::Migration
  def self.up
    create_table :collections_ontologies do |t|
      t.references :collection
      t.references :ontology
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :collections_ontologies
  end
end
