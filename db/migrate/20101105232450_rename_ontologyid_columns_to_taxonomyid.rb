class RenameOntologyidColumnsToTaxonomyid < ActiveRecord::Migration
    def self.up
        rename_column :categories, :ontology_id, :taxonomy_id
        rename_column :taxonomy_users, :ontology_id, :taxonomy_id
    end 
    def self.down
        # do nothing
    end
 end