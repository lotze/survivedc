class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.integer :tagger_id
      t.integer :taggee_id
      t.float :latitude
      t.float :longitude
      t.string :street_address
      t.string :user_agent
      t.string :ip_address
      t.string :device_id

      t.timestamps
    end
    add_index :tags, :tagger_id
  end

  def self.down
    drop_table :tags
  end
end
