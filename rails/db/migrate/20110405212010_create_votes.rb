class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :user_id
      t.integer :selection_id
      t.boolean :is_up

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
