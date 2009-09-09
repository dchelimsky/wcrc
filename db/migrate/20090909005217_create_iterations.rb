class CreateIterations < ActiveRecord::Migration
  def self.up
    create_table :iterations do |t|
      t.date :start_date
      t.integer :number_of_days
      t.timestamps
    end
  end

  def self.down
    drop_table :iterations
  end
end
