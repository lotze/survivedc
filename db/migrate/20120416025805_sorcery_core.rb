class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username,         :null => false  # if you use another field as a username, for example email, you can safely remove this field.
      t.string :email,            :null => false  # if you use this field as a username, you might want to make it :null => false.
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      
      t.boolean :is_chaser, :default => false, :null => false
      t.integer :checkpoint_num, :default => 0, :null => false
      t.datetime :last_checkpoint_at
      
      t.integer :onboarding_level, :default => 0, :null => false
      
      t.string :photo_url

      t.timestamps
    end
    add_index :users, :username
    add_index :users, :email
    add_index :users, :is_chaser
    add_index :users, [:checkpoint_num, :last_checkpoint_at]
  end

  def self.down
    drop_table :users
  end
end