class SetupAssociations < ActiveRecord::Migration
  def self.up
    create_table :classifications_periods, :id => false do |t|
      t.integer :classification_id
      t.integer :period_id
    end
  end

  def self.down
    drop_table :classifications_periods
  end
end
