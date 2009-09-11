require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IterationsController do
  describe "GET index" do
    before(:each) do
      Card.stub(:backlog).and_return []
    end

    it "assigns the backlog to @backlog" do
      backlog = mock("backlog")
      Card.stub(:backlog).and_return backlog
      get :index
      assigns[:backlog].should be(backlog)
    end
  end
  
  describe "GET new" do
    it "assigns a new Iteration to @iteration" do
      get :new
      assigns[:iteration].should be_a_new(Iteration)
    end
  end
  
  describe "POST create" do
    it "creates a new iteration" do
      Iteration.should_receive(:create!).with('these' => 'params')
      post :create, :iteration => {'these' => 'params'}
    end
    
    it "redirects to the index of iterations" do
      Iteration.stub(:create!)
      post :create, :iteration => {'these' => 'params'}
      response.should redirect_to(iterations_path)
    end
  end
end