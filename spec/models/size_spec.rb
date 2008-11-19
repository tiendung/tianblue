require File.dirname(__FILE__) + '/../spec_helper'

module ProductSpecHelper

  def valid_size_attributes
    {
      :name => "Name",
      :description => "A description of the size",
      :code => "m"
    }
  end

end

describe Size do
  include ProductSpecHelper

  before(:each) do
    @size = Size.new
  end

  it "should be valid" do
    @size.attributes = valid_size_attributes
    @size.should be_valid
  end
  it "should have a name" do
    @size.attributes = valid_size_attributes.except(:name)
    @size.should have_at_least(1).error_on(:name)
  end
  it "should have a unique name" do
    @size.attributes = valid_size_attributes
    @size.save
    @size2 = Size.new(valid_size_attributes.merge(:code=>"l"))
    @size2.should have_at_least(1).error_on(:name)
  end
  it "should have a unique code" do
    @size.attributes = valid_size_attributes
    @size.save
    @size2 = Size.new(valid_size_attributes.merge(:name=>"Large"))
    @size2.should have_at_least(1).error_on(:code)
  end
  it "should have a description" do
    @size.attributes = valid_size_attributes.except(:description)
    @size.should have_at_least(1).error_on(:description)
  end
  it "should have a code" do
    @size.attributes = valid_size_attributes.except(:code)
    @size.should have_at_least(1).error_on(:code)
  end
  it "code should be less than three characters" do
    @size.attributes = valid_size_attributes.except(:code)
    @size.code = "ABCD"
    @size.should have_at_least(1).error_on(:code)    
    @size.code = "ABC"
    @size.should be_valid
    @size.code = "A"
    @size.should be_valid
  end
  it "should be only numerals and lowercase letters" do
    @size.attributes = valid_size_attributes.except(:code)
    @size.code = "A?C"
    @size.should have_at_least(1).error_on(:code)    
  end
  it "should store code as lowercase" do
    @size.attributes = valid_size_attributes.except(:code)
    @size.code = "M"
    @size.save
    @size.code.should == "m"
  end
  it "should return the code for to_param for routing" do
    @size.attributes = valid_size_attributes
    @size.save
    @size.to_param.should == "m"
  end
  
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: sizes
#
#  id             :integer(11)     not null, primary key
#  code           :string(255)
#  description    :text
#  name           :string(255)
#  relative_order :integer(11)
#  created_at     :datetime
#  updated_at     :datetime

