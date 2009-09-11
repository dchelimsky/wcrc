require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Card do
  before(:each) do
    @valid_attributes = {
      :title => '',
      :description => '',
      :points => 2
    }
  end

  it "should create a new instance given valid attributes" do
    Card.create!(@valid_attributes)
  end
  
  describe ".backlog" do
    context "with one unassigned card" do
      it "includes only that card" do
        card = Card.create!(@valid_attributes)
        Card.backlog.should == [card]
      end
    end
    
    context "with one assigned card" do
      it "does not include the assigned card" do
        iteration = Iteration.create!(:start_date => '9/1/2009', :number_of_days => 7)
        assigned_card = Card.create!(@valid_attributes.merge(:iteration => iteration))
        Card.backlog.should_not include(assigned_card)
      end
    end
  end
  
  describe "iteration_id=" do
    context "with a non-zero id" do
      it "assigns the iteration" do
        Card.new(:iteration_id => 3).iteration_id.should == 3
      end
    end
    
    context "with 0" do
      it "assigns nil" do
        Card.new(:iteration_id => 0).iteration_id.should == nil
      end
    end

    context "with '0'" do
      it "assigns nil" do
        Card.new(:iteration_id => '0').iteration_id.should == nil
      end
    end
  end
end
