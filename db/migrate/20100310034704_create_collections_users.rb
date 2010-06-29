class CreateCollectionsUsers < ActiveRecord::Migration
  def self.up
    create_table :collections_users do |t|
      t.references :collection
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :collections_users
  end
end
