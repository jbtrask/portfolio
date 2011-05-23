class CreatePeriods < ActiveRecord::Migration
  def self.up
    create_table :periods do |t|
      t.integer :start_year
      t.integer :end_year

      t.timestamps
    end
  end

  def self.down
    drop_table :periods
  end
end
