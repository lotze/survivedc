class CreateLocationUpdates < ActiveRecord::Migration
  def self.up
    create_table :location_updates do |t|
      t.integer :user_id, :null => false
      t.float :latitude
      t.float :longitude
      t.boolean :is_chaser

      t.timestamps
    end
    add_index :location_updates, :created_at
    add_index :location_updates, [:is_chaser, :created_at]
  end

  def self.down
    drop_table :location_updates
  end
end
