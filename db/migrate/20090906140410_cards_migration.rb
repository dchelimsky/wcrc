class CardsMigration < ActiveRecord::Migration
  def self.up
    create_table :cards, :force => true do |t|
      t.string  :title
      t.string  :description
      t.integer :points
      t.timestamps
    end
  end

  def self.down
    drop_table :cards
  end
end
