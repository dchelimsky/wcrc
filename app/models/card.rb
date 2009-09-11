class Card < ActiveRecord::Base
  belongs_to :iteration
  acts_as_list :column => 'priority', :scope => :iteration
  
  named_scope :backlog, :conditions => {:iteration_id => nil}
  
  def iteration_id=(id)
    write_attribute(:iteration_id, id.to_i == 0 ? nil : id)
  end
end
