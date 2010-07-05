class CreateOntologies < ActiveRecord::Migration
  def self.up
    create_table :ontologies do |t|
      t.string :name
      t.string :status
      t.string :privacy
      t.string :meta
      t.string :url_about
      t.string :url_category_html
      t.string :url_category_xml
      t.references :language
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :ontologies
  end
end