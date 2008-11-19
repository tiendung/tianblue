require File.dirname(__FILE__) + '/../spec_helper'

describe HomeController do

  before(:each) do
    @category1 = mock_model(Category, :id => 1, :name => "category1")
    @category2 = mock_model(Category, :id => 2, :name => "category2")
    @categories = [@category1, @category2]

    @article_top = mock_model(Article, :id => 1, :title => "Article1")

    @image = mock_model(PageImage)
    @page = mock_model(Page, :id => 1, :title => "Home", :html_body=>"<h1>Hi</h1>", :image => @image)

    @cart = mock_model(Cart, :id => 10)
    Cart.stub!(:find).and_return(@cart)
    session[:cart] = 10
  end

  describe "GET 'index' - / - " do

    before(:each) do
      Page.stub!(:find_by_permalink).with("home").and_return(@page)
      Category.stub!(:featured).and_return(@categories)
      Article.stub!(:top).and_return(@article_top)
    end

    def do_get
      get :index
    end

    it "should find a cart in database or create one" do
      Cart.should_receive(:find_or_create_by_id).with(10).at_least(1).times.and_return(@cart)
      do_get
    end
    it "should create a new cart" do
      do_get
      assigns[:cart].should_not be_nil
    end

    it "should display the welcome message" do
      Page.should_receive(:find_by_permalink).with("home").and_return(@page)
      do_get
      assigns[:welcome_message].should == @page.html_body
    end
    it "should display the homepage image" do
      do_get
      assigns[:image].should == @page.image
    end

    it "should find two featured categories" do
      Category.should_receive(:featured).and_return(@catgeories)
      do_get
      # assigns[:categories].should == @categories
    end
    it "should find top news item" do
      Article.should_receive(:top).and_return(@article_top)
      do_get
      assigns[:top_news].should == @article_top
    end
    it "should find two sub news items"

  end


end
