class Iteration < ActiveRecord::Base
  has_many :cards
  
  named_scope :all_but, lambda { |iteration| {:conditions => ['id != ?', iteration.id]} }
end
