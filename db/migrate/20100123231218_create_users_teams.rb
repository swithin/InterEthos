class CreateUsersTeams < ActiveRecord::Migration
  def self.up
    create_table :users_teams do |t|
      t.references :team
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :users_teams
  end
end
