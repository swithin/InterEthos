class AddTaxonomyidColumnToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :taxonomy_id, :integer
  end

  def self.down
    # do nothing
  end
end