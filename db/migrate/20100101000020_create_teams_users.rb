class CreateTeamsUsers < ActiveRecord::Migration
  def self.up
    create_table :teams_users do |t|
      t.references :team
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :teams_users
  end
end
