class AddGroupsIdToSelections < ActiveRecord::Migration
  def self.up
    add_column :selections, :group_id, :integer
  end

  def self.down
    remove_column :selections, :group_id
  end
end
