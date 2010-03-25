class CreateCollectionsTaxonomies < ActiveRecord::Migration
  def self.up
    create_table :collections_taxonomies do |t|
      t.references :collection
      t.references :taxonomy
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :collections_taxonomies
  end
end
