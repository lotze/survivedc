class AddAccuracyToCheckins < ActiveRecord::Migration
  def self.up
    add_column :checkins, :accuracy, :float
    change_column :checkins, :longitude, :float, :limit => 36
    change_column :checkins, :latitude, :float, :limit => 36
  end

  def self.down
    remove_column :checkins, :accuracy
  end
end
