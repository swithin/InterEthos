class CreateTeamUsers < ActiveRecord::Migration
  def self.up
    create_table :team_users do |t|
      t.references :team
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :team_users
  end
end