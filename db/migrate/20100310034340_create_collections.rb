class CreateCollections < ActiveRecord::Migration
  def self.up
    create_table :collections do |t|
      t.string :name
      t.string :status
      t.string :organization
      t.text :contact_info
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :collections
  end
end
