class CreateGroupsUsers < ActiveRecord::Migration
  def self.up
    create_table :groups_users do |t|
      t.integer :group_id
      t.integer :user_id
      t.boolean :is_group_admin

      t.timestamps
    end
  end

  def self.down
    drop_table :groups_users
  end
end
