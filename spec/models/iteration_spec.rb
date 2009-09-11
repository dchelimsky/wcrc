require 'spec/spec_helper'

describe Iteration do
  before(:each) do
    @valid_attributes = {
      :start_date => '9/1/2009',
      :number_of_days => 7
    }
  end

  it "should create a new instance given valid attributes" do
    Iteration.create!(@valid_attributes)
  end
  
  describe "all_but" do
    before(:each) do
      @iterations = [
        Iteration.create!(:start_date => "9/12/2000"),
        Iteration.create!(:start_date => "9/18/2000")
      ]
      
    end
    it "includes all other iterations" do
      Iteration.all_but(@iterations[0]).should include(@iterations[1])
    end
    
    it "excludes the submitted iteration" do
      Iteration.all_but(@iterations[0]).should_not include(@iterations[0])
    end
  end
  
end
