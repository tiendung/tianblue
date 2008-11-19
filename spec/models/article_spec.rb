require File.dirname(__FILE__) + '/../spec_helper'

module ArticleSpecHelper

  def valid_article_attributes
    {
      :title => "Article Title",
      :body => "Body for article.",
      :summary => "Summary for article.",
      :posted_at => Time.now-1.day
    }
  end

end

describe Article do
  include ArticleSpecHelper

  before(:each) do
    @article = Article.new
  end

  it "should be valid" do
    @article.attributes = valid_article_attributes
    @article.should be_valid
  end

  it "should have many image" do
    @article.should have_many(:images)
  end
  it "should have a title" do
    @article.attributes = valid_article_attributes.except(:title)
    @article.should have(1).error_on(:title)
  end
  
  it "should have a body" do
    @article.attributes = valid_article_attributes.except(:body)
    @article.should have(1).error_on(:body)
  end
  it "should have a summary" do
    @article.attributes = valid_article_attributes.except(:summary)
    @article.should have(1).error_on(:summary)
  end

  it "should have an HTML body based on textile version of body attribute" do
    @article.attributes = valid_article_attributes
    @article.html_body.should eql(RedCloth.new(@article.body).to_html)
    @article.html_body.should eql("<p>Body for article.</p>")
  end
  it "should have an HTML summary based on textile version of summary attribute" do
    @article.attributes = valid_article_attributes
    @article.html_summary.should eql(RedCloth.new(@article.summary).to_html)
    @article.html_summary.should eql("<p>Summary for article.</p>")
  end

  it "should assign a posted date of now if one not assigned" do
    @article.attributes = valid_article_attributes.except(:posted_at)
    @article.save
    @article.posted_at.should_not be_nil
    @article.posted_at.utc.should be_close(Time.now.utc, 0.1)
  end
  it "should assign a posted date if provided" do
    @article = Article.create(valid_article_attributes)
    @article.posted_at.utc.should be_close((Time.now-1.days).utc, 0.1)
  end
  
  it "should return the most recent article by posted_at" do
    @article1 = Article.create(valid_article_attributes.merge(:posted_at=>Time.now+5.days))
    @article2 = Article.create(valid_article_attributes.merge(:posted_at=>Time.now-2.days))
    @article3 = Article.create(valid_article_attributes.merge(:posted_at=>Time.now-1.days))
    Article.top.should == @article3
  end
  it "should return the current articles by posted_at" do
    @article1 = Article.create(valid_article_attributes.merge(:posted_at=>Time.now+5.days))
    @article2 = Article.create(valid_article_attributes.merge(:posted_at=>Time.now-2.days))
    @article3 = Article.create(valid_article_attributes.merge(:posted_at=>Time.now-1.days))
    Article.current.should == [@article3, @article2]
  end
  
  
  it "should set a permalink on save if one is not already set" do
    @article.attributes = valid_article_attributes
    @article.save
    @article.permalink.should == (Time.now-1.day).strftime("%d-%m-%y")+"-article-title"
  end
  it "should remove punctuation and replaces spaces to create permalink" do
    @article.attributes = valid_article_attributes.except(:title)
    @article.title = "  Can this  be a title? "
    @article.save
    @article.permalink.should == (Time.now-1.day).strftime("%d-%m-%y")+"-can-this-be-a-title"
  end
  it "should return the permalink for to_param for routing" do
    @article.attributes = valid_article_attributes
    @article.save
    @article.to_param.should == (Time.now-1.day).strftime("%d-%m-%y")+"-article-title"
    @article.to_param.should == @article.permalink
  end


  it "should return the first mini image filename" do
    @article.attributes = valid_article_attributes
    @article.images.should be_empty
    @article.mini_image_filename.should be_false
    image = ArticleImage.new
    image.stub!(:public_filename).with(:mini).and_return("mini.jpg")
    @article.images << image
    @article.mini_image_filename.should == "mini.jpg"
    image2 = ArticleImage.new
    image2.stub!(:public_filename).with(:mini).and_return("mini2.jpg")
    @article.images << image2
    @article.mini_image_filename.should == "mini.jpg"
  end
  

end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: articles
#
#  id         :integer(11)     not null, primary key
#  body       :text
#  permalink  :string(255)
#  summary    :text
#  title      :string(255)
#  created_at :datetime
#  posted_at  :datetime
#  updated_at :datetime

