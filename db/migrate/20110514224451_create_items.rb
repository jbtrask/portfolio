class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :title
      t.date :date
      t.string :description
      t.string :medium
      t.string :classification
      t.float :physical_width
      t.float :physical_height
      t.float :physical_depth
      t.integer :file_width
      t.integer :file_height
      t.string :tags
      t.string :keywords
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
