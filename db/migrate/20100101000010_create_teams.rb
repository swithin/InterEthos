class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name
      t.text :description
      t.string :privacy
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end