class CreateSelections < ActiveRecord::Migration
  def self.up
    create_table :selections do |t|
      t.date :date_created
      t.integer :place_id
    end
  end

  def self.down
    drop_table :selections
  end
end
