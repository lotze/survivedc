class CreateProgresses < ActiveRecord::Migration
  def self.up
    create_table :progresses do |t|
      t.integer :checkpoint_num
      t.integer :num_people

      t.timestamps
    end
    add_index :progresses, [:checkpoint_num, :created_at]
  end

  def self.down
    drop_table :progresses
  end
end
