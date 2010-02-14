class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :category_id
      t.integer :synonym_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :relationships
  end
end
