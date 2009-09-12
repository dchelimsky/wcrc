require 'spec/spec_helper'

describe Iteration do
  before(:each) do
    @valid_attributes = {
      :start_date => '9/1/2009',
      :number_of_days => 7
    }
  end

  it "should create a new instance given valid attributes" do
    Iteration.create!(@valid_attributes)
  end

  describe "<<" do
    it "appends the card to its cards" do
      iteration = Iteration.create!
      card = Card.create!
      iteration << card
      iteration.cards.should include(card)
    end

    context "with no cards" do
      it "assigns it priority 1" do
        iteration = Iteration.create!
        card      = Card.create!
        iteration << card
        card.priority.should == 1
      end
    end

    context "with 1 card" do
      it "assigns the card priority 2" do
        iteration = Iteration.create!
        iteration << Card.create!
        card      = Card.create!
        iteration << card
        card.priority.should == 2
      end
    end
  end

end
