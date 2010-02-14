class DataAddCategories < ActiveRecord::Migration
  def self.up
    Category.load_from_file
  end

  def self.down
    Category.delete_all
  end
end
