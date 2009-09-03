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
end
