class RenameOntologyUsersToTaxonomyUsers < ActiveRecord::Migration
    def self.up
        rename_table :ontology_users, :taxonomy_users
    end 
    def self.down
        # do nothing
    end
 end