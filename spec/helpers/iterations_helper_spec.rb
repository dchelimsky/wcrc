require 'spec/spec_helper'

describe IterationsHelper do
  describe "#destination_options_for_cards_in(iteration)" do
    context "two iterations" do
      it "formats into options list for call to select" do
        iteration = Iteration.create!(:start_date => "9/8/2009")
        Iteration.stub(:all_but).and_return([iteration])
        helper.destination_options_for_cards_in(iteration).should include(["Iteration: #{iteration.start_date.to_s(:iteration_start_date)}", iteration.id])
      end
      
      it "asks for all iterations but the given one" do
        iteration = stub_model(Iteration)
        Iteration.should_receive(:all_but).with(iteration).and_return([])
        helper.destination_options_for_cards_in(iteration)
      end
      
      it "includes the backlog option" do
        Iteration.stub(:all_but).and_return([])
        helper.destination_options_for_cards_in(stub_model(Iteration)).should include(["Backlog", 0])
      end
      
      context "passing in nil" do
        it "excludes backlog" do
          Iteration.stub(:all_but).and_return([])
          helper.destination_options_for_cards_in(:backlog).should_not include(["Backlog", 0])
        end
      end
    end
  end
end