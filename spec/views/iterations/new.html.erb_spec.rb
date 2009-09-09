require 'spec/spec_helper'

describe "/iterations/new.html.erb" do
  it "renders a form with correct fields" do
    assigns[:iteration] = stub_model(Iteration,
     :start_date => '9/1/2009',
     :number_of_days => 7
    )
    render
    response.should have_selector("form") do |form|
      form.should have_selector("input", :type => "text", :name => "iteration[start_date]")
      form.should have_selector("input", :type => "text", :name => "iteration[number_of_days]")
      form.should have_selector("input", :type => "submit", :value => "Create")
    end
  end
end