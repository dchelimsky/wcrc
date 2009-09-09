require 'spec/spec_helper'

Spec::Matchers.define :display do |iteration|
  match do |response|
    response.body.include?("Iteration #{@number}") &&
    response.body.include?(iteration.start_date.to_s :iteration_start_date) &&
    response.body.include?(iteration.number_of_days.to_s)
  end
  
  failure_message_for_should do |response|
    "expected the html\n#{response.body} to display the iteration #{iteration.inspect}"
  end

  def number(number)
    @number= number
    self
  end
end


describe "iterations/index.html.erb" do
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
      response.should display(iteration).number('1')
    end
  end
  
  context "with two iterations" do
    it "displays the iterations" do
      assigns[:iterations] = [
        iteration_1 = stub_model(Iteration,
          :id => 37,
          :start_date => "10/15/2012",
          :number_of_days => 7
        ),
        iteration_2 = stub_model(Iteration,
          :id => 42,
          :start_date => "10/22/2012",
          :number_of_days => 7
        )
      ]
      render
      response.should display(iteration_1).number('1')
      response.should display(iteration_2).number('2')
    end
  end
end