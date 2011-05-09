class CreateGroupsPlaces < ActiveRecord::Migration
  def self.up
    create_table :groups_places do |t|
      t.integer :group_id
      t.integer :place_id

      t.timestamps
    end
  end

  def self.down
    drop_table :groups_places
  end
end
