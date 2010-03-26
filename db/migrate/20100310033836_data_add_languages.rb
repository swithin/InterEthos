class DataAddLanguages < ActiveRecord::Migration
  def self.up
    Language.load_from_file
  end

  def self.down
    Language.delete_all
  end
end
