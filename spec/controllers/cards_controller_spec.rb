require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

Spec::Matchers.define :be_a_new do |model_class|
  match do |record|
    model_class === record &&
    record.new_record?
  end
end

describe CardsController do
  describe "GET 'index'" do
    it "assigns all Cards to @cards" do
      Card.should_receive(:all).and_return(
        cards = [stub_model(Card)]
      )
      get :index
      assigns[:cards].should be(cards)
    end
  end
  
  describe "GET 'new'" do
    it "assigns a new Card to @card" do
      get :new
      assigns[:card].should be_a_new(Card)
    end
  end
  
  describe "POST 'create'" do
    it "redirects to 'index'" do
      post :create, :card => {}
      response.should redirect_to(cards_path)
    end
    
    it "creates a new Card" do
      Card.should_receive(:create!).
        with({'these' => 'params'})
      post :create, :card => {'these' => 'params'}
    end
  end
end
