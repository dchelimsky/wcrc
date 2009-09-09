class Card < ActiveRecord::Base
  belongs_to :iteration
  
  named_scope :backlog, :conditions => {:iteration_id => nil}
end
