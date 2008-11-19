require File.dirname(__FILE__) + '/../../spec_helper'

describe "INDEX home - / -" do

  before(:each) do
    @category1 = mock_model( Category, :name => "Category1", :to_param => "SKU1" )
    @category2 = mock_model( Category, :name => "Category2", :to_param => "SKU2" )
    @category1.stub!(:mini_image_filename).at_least(1).times.and_return("image1-1.jpg")
    @category2.stub!(:mini_image_filename).at_least(1).times.and_return("image2-1.jpg")

    @page = mock_model(Page, :id => 1, :name => "Home", :html_body => "<h1>Hi</h1>" )

    @image = mock_model(PageImage)
    @image.stub!(:public_filename).with(:home).and_return("image1.jpg")

    @article_top = mock_model(Article, :title => "Article1", :posted_at => Time.now, :html_summary=>"<p>Hi</p>", :to_param => "#{Time.now.strftime("%d-%m-%y")}-article1" )
    @article_top.stub!(:mini_image_filename).at_least(1).times.and_return("image3-1.jpg")

    assigns[:image] = @image
    assigns[:categories] = [@category1, @category2]
    assigns[:top_news] = @article_top
    assigns[:welcome_message] = @page.html_body

    render 'home/index'
  end

  it "should display body of home page" do
    response.should have_tag('h1', "Hi")
  end
  it "should display main image" do
    response.should have_tag('img.main')
  end
  it "should display linked images for categories" do
    response.should have_tag('li a img', 3)
  end
  it "should display article title" do
    response.should have_tag('li h2 a[href=?]', news_path(@article_top), @article_top.title)
  end

end