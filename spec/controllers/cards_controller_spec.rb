require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CardsController do
  describe "GET 'new'" do
    it "assigns a new card" do
      get 'new'
      assigns[:card].should be_a_new(Card)
    end
  end
  
  describe "GET 'show'" do
    it "assigns the sought after card to @card" do
      Card.stub(:find).with("37").and_return(card = stub_model(Card))
      get 'show', :id => 37
      assigns[:card].should be(card)
    end
  end
  
  describe "POST 'create'" do
    it "creates a card with passed in params" do
      Card.should_receive(:create!).with({'these' => 'params'})
      post 'create', :card => {'these' => 'params'}
    end

    it "redirects to the backlog" do
      post 'create', :card => {}
      response.should redirect_to(iterations_path)
    end
  end
  
  describe "PUT 'update'" do
    before(:each) do
      request.env['HTTP_REFERER'] = '/whatever'
      @card = Card.create!
      @iteration = Iteration.create!
    end
    
    it "redirects back to referrer" do
      put :update, :id => @card.id, :card => {}
      response.should redirect_to('http://test.host/whatever')
    end
    
    context "with commit => Move to" do
      it "adds itself to the Iteration" do
        put :update, :id => @card.id, :commit => "Move to:", :card => {:iteration_id => @iteration.id.to_s}
        @iteration.cards.should include(@card)
      end
    end
    
    context "with commit => Move up" do
      it "moves calls move_up on the card" do
        other = Card.create!
        @iteration << other
        @iteration << @card
        put :update, :id => @card.id, :commit => "Move up"
        @card.reload.priority.should == 1
        other.reload.priority.should == 2
      end
    end
    
    context "with commit => Move up" do
      it "moves calls move_up on the card" do
        other = Card.create!
        @iteration << other
        @iteration << @card
        put :update, :id => other.id, :commit => "Move down"
        @card.reload.priority.should == 1
        other.reload.priority.should == 2
      end
    end
  end
end
