require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CardsController do
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

    it "redirects to the backlog" do
      post 'create', :card => {}
      response.should redirect_to(backlog_path)
    end
  end
  
  describe "PUT 'update'" do
    before(:each) do
      request.env['HTTP_REFERER'] = '/whatever'
      @card = stub_model(Card)
      Card.stub(:find).and_return(@card)

      @card.stub(:update_attributes!)
    end
    
    it "updates the correct card" do
      Card.should_receive(:find).with("37").and_return(@card)
      @card.should_receive(:update_attributes!).with('these' => 'params')
      put :update, :id => "37", :card => {'these' => 'params'}
    end
    
    it "redirects back to referrer" do
      put :update, :id => "42", :card => {}
      response.should redirect_to('http://test.host/whatever')
    end
  end
end
