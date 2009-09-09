require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CardsController do
  describe "GET 'index'" do
    it "assigns all cards" do
      Card.stub(:all).and_return(all_cards = [])
      get 'index'
      assigns[:cards].should equal(all_cards)
    end
  end

  describe "GET 'new'" do
    it "assigns a new card" do
      get 'new'
      assigns[:card].should be_a_new(Card)
    end
  end

  describe "POST 'create'" do
    it "creates a card with passed in params" do
      Card.should_receive(:create!).with({'these' => 'params'})
      post 'create', :card => {'these' => 'params'}
    end

    it "redirects to the index" do
      post 'create', :card => {}
      response.should redirect_to(cards_path)
    end
  end
end
