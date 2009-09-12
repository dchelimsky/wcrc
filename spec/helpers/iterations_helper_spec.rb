require 'spec/spec_helper'

describe IterationsHelper do
  describe IterationsHelper::IterationsCache do
    before(:each) do
      @cache = IterationsHelper::IterationsCache.new(
        @iterations = [
          stub_model(Iteration, :start_date => '9/1/2009'),
          stub_model(Iteration, :start_date => '9/8/2009')
        ]
      )
    end
    it "includes the non-submitted iterations" do
      @cache.destination_options_for_cards_in(@iterations[0]).
        should include(["Iteration: #{@iterations[1].start_date.to_s(:iteration_start_date)}", @iterations[1].id])
    end
    
    it "exclude the submitted iteration" do
      @cache.destination_options_for_cards_in(@iterations[0]).
        should_not include(["Iteration: #{@iterations[0].start_date.to_s(:iteration_start_date)}", @iterations[0].id])
    end
    
    it "includes the backlog option" do
      @cache.destination_options_for_cards_in(@iterations[0]).should include(["Backlog", 0])
    end
    
    context "passing in :backlog" do
      it "excludes backlog" do
        @cache.destination_options_for_cards_in(:backlog).should_not include(["Backlog", 0])
      end
      
      it "includes all of the other iterations" do
        @iterations.each do |iteration|
          @cache.destination_options_for_cards_in(:backlog).
            should include(["Iteration: #{iteration.start_date.to_s(:iteration_start_date)}", iteration.id])
        end
      end
    end
  end
  
  
  describe "#destination_options_for_cards_in(iteration)" do
    context "two iterations" do
      xit "formats into options list for call to select" do
        iteration = Iteration.create!(:start_date => "9/8/2009")
        Iteration.stub(:all_but).and_return([iteration])
        helper.destination_options_for_cards_in(iteration).should include(["Iteration: #{iteration.start_date.to_s(:iteration_start_date)}", iteration.id])
      end
      
      xit "asks for all iterations but the given one" do
        iteration = stub_model(Iteration)
        Iteration.should_receive(:all_but).with(iteration).and_return([])
        helper.destination_options_for_cards_in(iteration)
      end
      
      xit "includes the backlog option" do
        Iteration.stub(:all_but).and_return([])
        helper.destination_options_for_cards_in(stub_model(Iteration)).should include(["Backlog", 0])
      end
      
      context "passing in :backlog" do
        it "excludes backlog" do
          Iteration.stub(:all).and_return([])
          helper.destination_options_for_cards_in(:backlog).should_not include(["Backlog", 0])
        end
        
        it "passes nil to Iteration.all" do
          Iteration.should_receive(:all).and_return []
          helper.destination_options_for_cards_in(:backlog)
        end
      end
    end
  end
end