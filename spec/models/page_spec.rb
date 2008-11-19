require File.dirname(__FILE__) + '/../spec_helper'

module PageSpecHelper

  def valid_page_attributes
    {
      :name => "name",
      :body => "Body Text"
    }
  end

end

describe Page do
  include PageSpecHelper
  
  before(:each) do
    @page = Page.new
  end

  it "should be valid" do
    @page.attributes = valid_page_attributes
    @page.should be_valid
  end
  it "should have one image" do
    @page.should have_one(:image)
  end
  it "should have a name" do
    @page.attributes = valid_page_attributes.except(:name)
    @page.should have(1).error_on(:name)
  end
  it "should have a body" do
    @page.attributes = valid_page_attributes.except(:body)
    @page.should have(1).error_on(:body)
  end
  it "should have an HTML body based on textile version of body" do
    @page.attributes = valid_page_attributes
    @page.html_body.should eql(RedCloth.new(@page.body).to_html)
    @page.html_body.should eql("<p>Body Text</p>")
  end
  it "should set a permalink on save if one is not already set" do
    @page.attributes = valid_page_attributes
    @page.save
    @page.permalink.should == "name"
  end
  it "should remove punctuation and replaces spaces to create permalink" do
    @page.attributes = valid_page_attributes.except(:name)
    @page.name = "  Can this  be a name? "
    @page.save
    @page.permalink.should == "can-this-be-a-name"
  end
  it "should return the permalink for to_param for routing" do
    @page.attributes = valid_page_attributes
    @page.save
    @page.to_param.should == "name"
    @page.to_param.should == @page.permalink
  end
  
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: pages
#
#  id         :integer(11)     not null, primary key
#  body       :text
#  name       :string(255)
#  permalink  :string(255)
#  created_at :datetime
#  updated_at :datetime

