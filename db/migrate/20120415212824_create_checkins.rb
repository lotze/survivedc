class CreateCheckins < ActiveRecord::Migration
  def self.up
    create_table :checkins do |t|
      t.integer :user_id, :null => false
      t.integer :checkpoint_id, :null => false
      t.integer :checkpoint_num, :null => false
      t.float :latitude
      t.float :longitude
      t.string :user_agent, :null => false
      t.string :device_id
      t.string :ip_address, :null => false

      t.timestamps
    end
    add_index :checkins, [:user_id, :checkpoint_id], :unique => true
  end

  def self.down
    drop_table :checkins
  end
end
