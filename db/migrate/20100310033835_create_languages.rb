class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :bibliographic_code, :null => false, :limit => 3
      t.string :terminologic_code
      t.string :digit2_code
      t.string :english_name, :null => false
      t.string :french_name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :languages
  end
end
