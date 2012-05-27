class IncreaseLocationPrecision < ActiveRecord::Migration
  def self.up
    add_column :location_updates, :accuracy, :float, :limit => 36
    change_column :location_updates, :longitude, :float, :limit => 36
    change_column :location_updates, :latitude, :float, :limit => 36
    change_column :checkpoints, :longitude, :float, :limit => 36
    change_column :checkpoints, :latitude, :float, :limit => 36
  end

  def self.down
  end
end
