class AddEmailFlagsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :bounced, :boolean, :default => false, :null => false
    add_column :users, :donotemail, :boolean, :default => false, :null => false
    add_column :users, :unsubscribe_token, :string
    add_index :users, :unsubscribe_token, :unique => true
  end

  def self.down
    remove_column :users, :donotemail
    remove_column :users, :bounced
    remove_column :users, :unsubscribe_token
  end
end
