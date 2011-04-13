class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.string :name
      t.integer :category_id
      t.boolean :is_catered

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
