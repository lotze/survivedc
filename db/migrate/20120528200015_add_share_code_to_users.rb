class AddShareCodeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :share_code, :string
    add_index :users, :share_code, :unique => true
  end

  def self.down
    remove_column :users, :share_code
  end
end
