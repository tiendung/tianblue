require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles with in and out of stock articles" do
  before(:each) do
    @article1 = mock_model( Article, :title => "Article1", :posted_at => Time.now, :to_param=>"art1", :html_summary => "<p>Test1</p>" )
    @article2 = mock_model( Article, :title => "Article2", :posted_at => Time.now-1.day, :to_param=>"art2", :html_summary => "<p>Test2</p>" )
    @article3 = mock_model( Article, :title => "Article3", :posted_at => Time.now-2.days, :to_param=>"art3", :html_summary => "<p>Test3</p>" )

    @article1.stub!(:mini_image_filename).at_least(1).times.and_return("image1-1.jpg")
    @article2.stub!(:mini_image_filename).at_least(1).times.and_return("image2-1.jpg")
    @article3.stub!(:mini_image_filename).at_least(1).times.and_return("image3-1.jpg")

    assigns[:articles] = [@article1, @article2, @article3]
    assigns[:page_title] = "Page Title"
    
    render 'articles/index'
  end
  
  it "should display page title articles" do
    response.should have_tag('h1', "Page Title")
  end
  
  it "should display titles" do
    response.should have_tag('li h2', /Article./, 3)
  end
  it "should display dates" do
    response.should have_tag('li p.date', 3)
  end
  it "should display images" do
    response.should have_tag('li p', /Test./, 3)
  end
  it "should display more links" do
    response.should have_tag('li a img', 3)
  end
    
end