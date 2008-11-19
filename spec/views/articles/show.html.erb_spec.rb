require File.dirname(__FILE__) + '/../../spec_helper'

describe "SHOW article - /news/xx -" do

  before(:each) do
    @article = mock_model( Article,
      :id => 1,
      :title => "Title",
      :html_body => "<p>Description</p>",
      :images => [
        @image1 = mock_model( ArticleImage, :to_param => 1),
        @image2 = mock_model( ArticleImage, :to_param => 2)
      ],
      :to_param => "1"
    )
    @image1.stub!(:public_filename).with(:main).and_return('image1.jpg')
    @image2.stub!(:public_filename).with(:main).and_return('image2.jpg')

    assigns[:article] = @article
    assigns[:images] = @article.images
    assigns[:page_title] = @article.title
    render 'articles/show'
  end

  it "should display name" do
    response.should have_tag('h1', @article.title)
  end

  it "should display body" do
    response.should have_tag('p', "Description")
  end
  it "should display images" do
    response.should have_tag('img', 2)
  end
  
end