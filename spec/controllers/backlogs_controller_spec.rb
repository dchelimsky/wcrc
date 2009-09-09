require 'spec/spec_helper'

describe BacklogsController do
  describe "GET show" do
    it "assigns backlog cards" do
      Card.stub(:backlog).and_return(all_cards = [])
      get 'show'
      assigns[:cards].should equal(all_cards)
    end
  end
end
