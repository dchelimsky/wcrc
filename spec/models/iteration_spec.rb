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
  
end
