class DataAddValidations < ActiveRecord::Migration
  def self.up
    Validation.load_from_file
  end

  def self.down
    Validation.delete_all
  end
end