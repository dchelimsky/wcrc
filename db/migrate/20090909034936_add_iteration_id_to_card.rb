class AddIterationIdToCard < ActiveRecord::Migration
  def self.up
    add_column :cards, :iteration_id, :integer
  end

  def self.down
    remove_column :cards, :iteration_id
  end
end
