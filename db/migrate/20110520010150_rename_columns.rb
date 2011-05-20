class RenameColumns < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.rename :classification, :classification_id
      t.rename :medium, :medium_id
    end
  end

  def self.down
    change_table :items do |t|
      t.rename :classification_id, :classification
      t.rename :medium_id, :medium
    end
  end
end
