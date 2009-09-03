require 'spec/spec_helper'

describe "/cards/new.html.erb" do
  it "renders a form with correct fields" do
    assigns[:card] = stub_model(Card,
     :title => 'ignore me',
     :description => 'ignore me too',
     :points => 10
    )
    render
    response.should have_selector("form") do |form|
      form.should have_selector("input", :type => "text", :name => "card[title]")
      form.should have_selector("input", :type => "text", :name => "card[description]")
      form.should have_selector("input", :type => "text", :name => "card[points]")
      form.should have_selector("input", :type => "submit", :value => "Create")
    end
  end
end