class RenameOntologiesToTaxonomies < ActiveRecord::Migration
    def self.up
        rename_table :ontologies, :taxonomies
    end 
    def self.down
        rename_table :taxonomies, :ontologies
    end
 end