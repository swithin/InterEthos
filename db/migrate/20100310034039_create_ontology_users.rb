class CreateOntologyUsers < ActiveRecord::Migration
  def self.up
    create_table :ontology_users do |t|
      t.references :ontology
      t.references :user
      t.references :language

      t.timestamps
    end
  end

  def self.down
    drop_table :ontology_users
  end
end
