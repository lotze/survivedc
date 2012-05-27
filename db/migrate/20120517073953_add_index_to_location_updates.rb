class AddIndexToLocationUpdates < ActiveRecord::Migration
  def self.up
    add_index :location_updates, [:user_id, :created_at]
  end

  def self.down
    remove_index :location_updates, [:user_id, :created_at]
  end
end
