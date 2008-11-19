require File.dirname(__FILE__) + '/../../spec_helper'

describe "SHOW a page" do
  
  before(:each) do
    @page = mock_model(Page, :id => 1, :name => "Home", :html_body => "<p>Hello</p>" )

    @image = mock_model(PageImage)
    @image.stub!(:public_filename).with(:main).and_return("image1.jpg")

    assigns[:image] = @image
    assigns[:page] = @page
    assigns[:page_title] = "Name"
  
    render 'pages/show'
  end

  it "should display page title" do
    response.should have_tag('h1', "Name")
  end
  it "should display the html body" do
    response.should have_tag('p', "Hello")    
  end
  it "should display main image" do
    response.should have_tag('img.main')
  end
end
