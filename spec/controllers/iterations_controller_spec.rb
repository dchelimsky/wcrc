require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IterationsController do
  describe "GET index" do
    it "assigns all iterations to @iterations" do
      iterations = mock("iterations")
      Iteration.stub(:all).and_return iterations
      get :index
      assigns[:iterations].should be(iterations)
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