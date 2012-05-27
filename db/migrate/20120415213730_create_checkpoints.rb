class CreateCheckpoints < ActiveRecord::Migration
  def self.up
    create_table :checkpoints do |t|
      t.float :longitude
      t.float :latitude
      t.string :street_address
      t.string :name
      t.string :secret_code
      t.boolean :is_mobile
      t.boolean :is_bonus
      t.boolean :is_finish
      t.integer :num_players, :default => 0

      t.timestamps
    end
    add_index :checkpoints, :secret_code
  end

  def self.down
    drop_table :checkpoints
  end
end
