class AddMethodToCheckins < ActiveRecord::Migration
  def self.up
    add_column :checkins, :method, :string
  end

  def self.down
    remove_column :checkins, :method
  end
end
