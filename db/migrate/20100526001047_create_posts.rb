class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :post_title
      t.text :post_text
      t.string :post_author
      t.string :author_email
      t.integer :topic_id
      t.integer :collection_id
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
