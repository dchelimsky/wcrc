require 'spec/spec_helper'

describe "/backlogs/show.html.erb" do
  context "with 1 card" do
    it "displays 1 Card" do
      card = stub_model(Card,
                          :title => 'card title',
                          :description => 'card description',
                          :points => 15)
      assigns[:cards] = [card]
      render
      
      response.should contain("1 Card")
      
      response.should display_the(card)
    end
  end
  context "with 2 cards" do
    it "displays 2 Cards" do
      cards = [
            stub_model(Card,
                      :title => 'card title',
                      :description => 'card description',
                      :points => 15),
            stub_model(Card,
                      :title => 'second title',
                      :description => 'second description',
                      :points => 16)
                      ]
      assigns[:cards] = cards
      render
      response.should contain("2 Cards")
      
      cards.each do |card|
        response.should display_the(card)
      end
    end
  end
end