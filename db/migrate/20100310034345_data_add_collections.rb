class DataAddCollections < ActiveRecord::Migration
  def self.up
    Collection.load_from_file
  end

  def self.down
    Collection.delete_all
  end
end
