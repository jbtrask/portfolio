class AddPeriod < ActiveRecord::Migration
  def self.up
    add_column :items, :period_id, :integer
  end

  def self.down
    remove_column :items, :period_id
  end
end
