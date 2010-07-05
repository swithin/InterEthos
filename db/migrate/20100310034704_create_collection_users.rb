class CreateCollectionUsers < ActiveRecord::Migration
  def self.up
    create_table :collection_users do |t|
      t.references :collection
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :collection_users
  end
end
