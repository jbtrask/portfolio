class AddUrlToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :full_path, :string
    add_column :items, :thumbnail_path, :string
  end

  def self.down
    remove_column :items, :thumbnail_path
    remove_column :items, :full_path
  end
end
