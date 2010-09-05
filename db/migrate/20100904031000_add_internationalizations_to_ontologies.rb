class AddInternationalizationsToOntologies < ActiveRecord::Migration
  def self.up
    add_column :ontologies, :internationalization_id, :integer
  end

  def self.down
    remove_column :ontologies, :internationalization_id
  end
end