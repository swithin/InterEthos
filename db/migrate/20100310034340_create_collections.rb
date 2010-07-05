class CreateCollections < ActiveRecord::Migration
  def self.up
    create_table :collections do |t|
      t.string :name
      t.string :status
      t.string :organization
      t.string :privacy
      t.string :meta
      t.string :url_about
      t.text :contact_info
      t.text :notes
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :collections
  end
end