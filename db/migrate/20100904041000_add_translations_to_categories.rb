class AddTranslationsToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :translation_id, :integer
  end

  def self.down
    remove_column :categories, :translation_id
  end
end