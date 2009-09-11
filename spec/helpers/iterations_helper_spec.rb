require 'spec/spec_helper'

describe IterationsHelper do
  describe "IterationCache" do
    context "with two iterations" do
      before(:each) do
        @iterations = [
            stub_model(Iteration, :start_date => "9/8/2009"),
            stub_model(Iteration, :start_date => "9/15/2009")
          ]
        @cache = IterationsHelper::IterationCache.new(@iterations)
      end
      describe "#destination_options_for_cards_in(iteration)" do
        it "formats into options list for call to select" do
          first = @iterations.first
          last = @iterations.last
          @cache.destination_options_for_cards_in(first).should include(["Iteration: #{last.start_date.to_s(:iteration_start_date)}", last.id])
        end

        it "excludes the submitted iteration" do
          iteration = @iterations.first
          @cache.destination_options_for_cards_in(iteration).should_not include(["Iteration: #{iteration.start_date.to_s(:iteration_start_date)}", iteration.id])
        end

        it "includes the backlog option" do
          @cache.destination_options_for_cards_in(stub_model(Iteration)).should include(["Backlog", 0])
        end

        context "passing in :backlog" do
          it "excludes backlog" do
            @cache.destination_options_for_cards_in(:backlog).should_not include(["Backlog", 0])
          end

          it "includes all the iterations" do
            @iterations.each do |iteration|
              @cache.destination_options_for_cards_in(:backlog).should include(["Iteration: #{iteration.start_date.to_s(:iteration_start_date)}", iteration.id])
            end
          end
        end
      end

      describe ".each" do
        it "delegates to the submitted iterations" do
          @cache.each do |iteration|
            @iterations -= [iteration]
          end
          @iterations.should be_empty
        end
      end
    end
  end


  Spec::Matchers.define :have_these do |iterations|
    match do |iteration_cache|
      iteration_cache.each do |iteration|
        iterations -= [iteration]
      end
      iterations.empty?
    end
  end

  describe "with_iterations" do
    it "creates iteration cache with all iterations" do
      Iteration.should_receive(:all).and_return(iterations = [stub_model(Iteration)])
      helper.with_iterations do |cache|
        cache.should have_these(iterations)
      end
    end
  end
end
