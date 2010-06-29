class CreateOntologiesUsers < ActiveRecord::Migration
  def self.up
    create_table :ontologies_users do |t|
      t.references :ontology
      t.references :user
      t.references :language

      t.timestamps
    end
  end

  def self.down
    drop_table :ontologies_users
  end
end
