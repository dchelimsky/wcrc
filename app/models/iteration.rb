class Iteration < ActiveRecord::Base
  has_many :cards, :order => 'priority' do
    def <<(card)
      card.remove_from_list
      card.iteration = proxy_owner
      card.insert_at proxy_owner.cards.count + 1
      card.save!
    end
  end
  
  def <<(card)
    cards << card
  end
end
