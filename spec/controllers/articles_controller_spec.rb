require File.dirname(__FILE__) + '/../spec_helper'

describe ArticlesController do

  describe "GET 'show' - /news/xx - " do
  
    before(:each) do
      @article = mock_model(Article, :id => 1, :to_param => "hello", :title => "ArticleName", :images => [mock_model(ArticleImage)], :html_body => "<p>Body Text.</p>")
      Article.stub!(:find_by_permalink).with("hello").and_return(@article)
    end
  
    def do_get
      get :show, :id => "hello"
    end
  
    describe "with a valid article" do
  
      it "should get the article" do
        Article.should_receive(:find_by_permalink).with("hello").and_return(@article)
        do_get
      end
      it "should assign found order to @order for the view" do
        do_get
        assigns[:article].should == @article
      end
      it "should assign page title for the view" do
        do_get
        assigns[:page_title].should == @article.title
      end
      it "should assign images for the view" do
        do_get
        assigns[:images].should == @article.images
      end
    end
  
    describe "with invalid article" do
  
      before(:each) do
        Article.stub!(:find_by_permalink).with("hello").and_return(nil)
      end
  
      it "should not get the article" do
        Article.should_receive(:find_by_permalink).with("hello").and_return(nil)
        do_get
      end
      it "should redirect to index" do
        do_get
        response.should be_redirect
        response.should redirect_to(root_url)
      end
    end
  
  end

  before(:each) do
    @article1 = mock_model(Article, :id => 1, :title => "Article1")
    @article2 = mock_model(Article, :id => 2, :title => "Article2")
    @article3 = mock_model(Article, :id => 3, :title => "Article3")
    @article4 = mock_model(Article, :id => 4, :title => "Article4")
    @articles = [@article1, @article2, @article3, @article4]
    @cart = mock_model(Cart, :id => 10)
    Cart.stub!(:find).and_return(@cart)
    session[:cart] = 10
  end

  describe "GET 'index' - /articles - " do

    before(:each) do
      Article.stub!(:current).and_return(@articles)
    end

    def do_get
      get :index
    end

    it "should find all the articles" do
      Article.should_receive(:current).and_return(@articles)
      do_get
    end
    it "should assign all articles to @articles" do
      do_get
      assigns[:articles].should == @articles
    end
    it "should set the title to Articles" do
      do_get
      assigns[:page_title].should == "Latest News"
    end

  end
  

end
