require 'spec/spec_helper'

describe "iterations/index.html.erb" do
  before(:each) do
    assigns[:iterations] = []
    assigns[:backlog] = []
  end
  context "with one iteration" do
    it "displays the iteration" do
      assigns[:iterations] = [
        iteration = stub_model(Iteration,
          :id => 37,
          :start_date => "10/15/2012",
          :number_of_days => 7
        )
      ]
      render
      response.should display_iteration(iteration).number('1')
    end
  
    context "with one card in backlog" do
      it "displays the card in the backlog" do
        assigns[:backlog] = [card = stub_model(Card, :title => "Example")]
        render
        response.should have_selector("div", :id => "backlog") do |scope|
          scope.should contain("Example")
        end
      end
    end
  end
  
  context "with two iterations" do
    before(:each) do
      assigns[:iterations] = [
        @iteration_1 = stub_model(Iteration,
          :id => 37,
          :start_date => "10/15/2012",
          :number_of_days => 7
        ),
        @iteration_2 = stub_model(Iteration,
          :id => 42,
          :start_date => "10/22/2012",
          :number_of_days => 7
        )
      ]
    end
    
    it "displays the iterations" do
      render
      response.should display_iteration(@iteration_1).number('1')
      response.should display_iteration(@iteration_2).number('2')
    end
    
        
    context "with one card" do
      it "displays the card beneath its iteration" do
        @iteration_1.stub(:cards).and_return([card = stub_model(Card, :title => "Example")])
        render
        response.should have_selector("div", :id => "iteration_#{@iteration_1.id}") do |scope|
          scope.should contain("Example")
        end
      end
      
      it "displays a link to the card" do
        @iteration_1.stub(:cards).and_return([card = stub_model(Card, :title => "Example")])
        render
        response.should have_selector("a", :href => card_path(card.id)) do |link|
          link.should contain("Example")
        end
      end
    end

  end
end