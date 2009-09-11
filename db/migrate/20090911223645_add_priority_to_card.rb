class AddPriorityToCard < ActiveRecord::Migration
  def self.up
    add_column :cards, :priority, :integer
  end

  def self.down
    remove_column :cards, :priority
  end
end
