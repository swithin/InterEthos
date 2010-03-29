class CreateTaxonomies < ActiveRecord::Migration
  def self.up
    create_table :taxonomies do |t|
      t.string :name
      t.string :status
      t.string :url_category_html
      t.string :url_category_xml
      t.references :language

      t.timestamps
    end
  end

  def self.down
    drop_table :taxonomies
  end
end
