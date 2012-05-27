class CreateFriendRequests < ActiveRecord::Migration
  def self.up
    create_table :friend_requests do |t|
      t.integer :requesting_id, :null => false
      t.integer :target_id
      t.string :target_email, :null => false
      t.boolean :approved, :null => false, :default => false
      t.string :code, :null => false

      t.timestamps
    end
    add_index :friend_requests, [:requesting_id, :target_email]
    add_index :friend_requests, [:requesting_id, :approved]
    add_index :friend_requests, :code, :unique => true
  end

  def self.down
    drop_table :friend_requests
  end
end
