class CreateTaxonomiesUsers < ActiveRecord::Migration
  def self.up
    create_table :taxonomies_users do |t|
      t.references :taxonomy
      t.references :user
      t.string :role

      t.timestamps
    end
  end

  def self.down
    drop_table :taxonomies_users
  end
end
