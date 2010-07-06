class CreateCategoryCollections < ActiveRecord::Migration
  def self.up
    create_table :category_collections do |t|
      t.references :collection
      t.references :category
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :category_collections
  end
end
