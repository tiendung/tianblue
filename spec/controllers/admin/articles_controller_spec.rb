require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::ArticlesController do
  fixtures :users

  before(:each) do
    login_as("tom")
  end

  describe "GET 'index' - /admin/articles -" do

    def do_get
      get :index
    end

    before(:each) do
      @article1 = mock_model(Article, :id => 1, :to_param => 1, :title => "ArticleTitle1")
      @article2 = mock_model(Article, :id => 2, :to_param => 2, :title => "ArticleTitle2")
      @articles = [@article1, @article2]
      Article.stub!(:all).and_return(@articles)
    end

    it "should find all articles" do
      Article.should_receive(:all).and_return(@articles)
      do_get
    end
    it "should assign to @articles for the view" do
      do_get
      assigns[:articles].should == [@article1, @article2]
    end
    it "should set a page_title for the view" do
      do_get
      assigns[:page_title].should == "Articles"
    end

  end

  describe "GET 'new' - /admin/articles/new - " do

    before(:each) do
      @article = mock_model(Article)
      Article.stub!(:new).with(no_args).and_return(@article)
    end

    def do_get
      get :new
    end

    it "should get the new article" do
      Article.should_receive(:new).with(no_args).and_return(@article)
      do_get
    end
    it "should assign found order to @order for the view" do
      do_get
      assigns[:article].should == @article
    end

  end

  describe "GET 'edit' - /admin/articles/xx/edit - " do

    before(:each) do
      @article = mock_model(Article, :id => 1, :to_param => 1, :images => [mock_model(ProductImage)], :title => "ArticleTitle")
      Article.stub!(:find_by_permalink).with("permalink").and_return(@article)
    end

    def do_get
      get :edit, :id => "permalink"
    end

    describe "with a valid article" do

      it "should get the article" do
        Article.should_receive(:find_by_permalink).with("permalink").and_return(@article)
        do_get
      end
      it "should assign found order to @order for the view" do
        do_get
        assigns[:article].should == @article
      end
      it "should assign page title for the view" do
        do_get
        assigns[:page_title].should == "Edit Article"
      end
      it "should return referenced article images" do
        do_get
        assigns[:images].should == @article.images
      end
    end

    describe "with invalid article" do

      before(:each) do
        Article.stub!(:find_by_permalink).with("permalink").and_return(nil)
      end

      it "should not get the article" do
        Article.should_receive(:find_by_permalink).with("permalink").and_return(nil)
        do_get
      end
      it "should redirect to index" do
        do_get
        response.should be_redirect
        response.should redirect_to(admin_articles_path)
      end
    end

  end

  describe "POST 'create' - /admin/articles/ - " do

    before(:each) do
      @params = {
        :article => {
          "title" => "ArticleTitle",
          "body" => "Body Text"
        }
      }
      @article = mock_model(Article, :id => 1, :to_param => 1, :title => "ArticleTitle")
      Article.stub!(:new).with(@params[:article]).and_return(@article)
      @article.stub!(:save).and_return(true)
    end

    def do_post
      post :create, @params
    end

    describe "with a valid article params" do

      it "should get the article" do
        Article.should_receive(:new).with(@params[:article]).and_return(@article)
        do_post
      end
      it "should save the article object" do
        @article.should_receive(:save).and_return(true)
        do_post
      end
      it "should set the flash notice" do
        do_post
        flash[:notice].should == "Article created"
      end
      it "should redirect to the article index" do
        do_post
        response.should be_redirect
        response.should redirect_to(admin_articles_path)
      end
        
    end

    describe "with invalid article" do

      before(:each) do
        @article.stub!(:save).and_return(false)
      end

      it "should set the flash error" do
        do_post
        flash[:error].should == "Could not create article"
      end
      it "should render the new action" do
        do_post
        response.should render_template("new")
      end
    end

  end

  describe "PUT 'update' - /admin/articles/xx - " do

    before(:each) do
      @params = {
        :id => "permalink",
        :article => {
          "title" => "ArticleTitle"
        }
      }
      @article = mock_model(Article, :id => 1, :to_param => 1, :title => "ArticleTitle")
      Article.stub!(:find_by_permalink).with("permalink").and_return(@article)
      @article.stub!(:update_attributes).with(@params[:article]).and_return(true)
    end

    def do_put
      put :update, @params
    end

    describe "with a valid article and params" do

      it "should get the article" do
        Article.should_receive(:find_by_permalink).with("permalink").and_return(@article)
        do_put
      end
      it "should save the article object" do
        @article.should_receive(:update_attributes).with(@params[:article]).and_return(true)
        do_put
      end
      it "should set the flash notice" do
        do_put
        flash[:notice].should == "Article updated"
      end
      it "should redirect to the article index" do
        do_put
        response.should be_redirect
        response.should redirect_to(admin_articles_path)
      end
        
    end

    describe "with invalid article params" do

      before(:each) do
        @article.stub!(:update_attributes).with(@params[:article]).and_return(false)
      end

      it "should set the flash error" do
        do_put
        flash[:error].should == "Could not update article"
      end
      it "should render the edit action" do
        do_put
        response.should render_template("edit")
      end
    end

    describe "with invalid article" do

      before(:each) do
        Article.stub!(:find_by_permalink).with("permalink").and_return(nil)
      end

      it "should not get the article" do
        Article.should_receive(:find_by_permalink).with("permalink").and_return(nil)
        do_put
      end
      it "should redirect to index" do
        do_put
        response.should be_redirect
        response.should redirect_to(admin_articles_path)
      end
    end

  end

  describe "DELETE 'destroy' - /admin/articles/xx - " do

    before(:each) do
      @params = {
        :id => "permalink",
      }
      @article = mock_model(Article, :id => 1, :to_param => 1, :images => [mock_model(ProductImage)], :title => "ArticleTitle")
      Article.stub!(:find_by_permalink).with("permalink").and_return(@article)
      @article.stub!(:destroy).and_return(true)
    end

    def do_delete
      delete :destroy, @params
    end

    describe "with a valid article and params" do

      it "should find the article object" do
        Article.should_receive(:find_by_permalink).with("permalink").and_return(@article)
        do_delete
      end
      it "should destroy the article object" do
        @article.should_receive(:destroy).and_return(true)
        do_delete
      end
      it "should set the flash notice" do
        do_delete
        flash[:notice].should == "Article destroyed"
      end
      it "should redirect to the article index" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_articles_path)
      end
        
    end

    describe "with failed delete" do

      before(:each) do
        @article.stub!(:destroy).and_return(false)
      end

      it "should set the flash error" do
        do_delete
        flash[:error].should == "Could not destroy article"
      end
    end

    describe "with invalid article" do

      before(:each) do
        Article.stub!(:find_by_permalink).with("permalink").and_return(nil)
      end

      it "should set the flash error" do
        do_delete
        flash[:error].should == "Could not find article to destroy"
      end
    end

  end

end