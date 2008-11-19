require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::ArticleImagesController do
  fixtures :users

  before(:each) do
    login_as("tom")
    @params = {
      :article_id => "permalink"
    }
    @article = mock_model(Article, :id => 1, :to_param => "permalink", :permalink => "permalink", :title => "ArticleTitle", :images => [])
    Article.stub!(:find_by_permalink).with(@params[:article_id]).and_return(@article)

  end

  describe "GET 'new' - /admin/articles/permalink/images/new - " do

    before(:each) do
      @image = mock_model(ArticleImage)
      ArticleImage.stub!(:new).and_return(@image)
    end

    def do_get
      get :new, @params
    end

    it "should render" do
      ArticleImage.should_receive(:new).with(no_args).and_return(@image)
      do_get
      response.should be_success
    end
    it "should get the article" do
      Article.should_receive(:find_by_permalink).at_least(1).times.with(@params[:article_id]).and_return(@article)
      do_get
      assigns[:article] = @article
    end
    it "should set the page title" do
      do_get
      assigns[:page_title].should == "New Image for ArticleTitle"
    end

  end
  
  describe "POST 'create' - /admin/articles/SKU/images - " do

    before(:each) do
      @params = @params.merge(
      :image => {
          "uploaded_data" => "blah"
      })
      @image = mock_model(ArticleImage)
      @article.images.stub!(:<<).with(@image).and_return(true)
      ArticleImage.stub!(:new).and_return(@image)
    end

    def do_post
      post :create, @params
    end
    
    describe "successfully" do
      it "should create a new article image" do
        ArticleImage.should_receive(:new).with(@params[:image]).and_return(@image)
        do_post
      end

      it "should get the article" do
        Article.should_receive(:find_by_permalink).at_least(1).times.with(@params[:article_id]).and_return(@article)
        do_post
        assigns[:article] = @article
      end

      it "should assign the image to the article (which saves it)" do
        @article.images.should_receive(:<<).with(@image).and_return(true)
        do_post
      end

      it "should set the flash notice" do
        do_post
        flash[:notice].should == "Image created successfully"
      end

      it "should redirect to the edit page for the article" do
        do_post
        response.should be_redirect
        response.should redirect_to(edit_admin_article_path(@article))
      end
    end

    describe "unsuccessfully" do
      before(:each) do
        @article.images.stub!(:<<).with(@image).and_return(false)
      end

      it "should fail to assign the image to the article" do
        @article.images.should_receive(:<<).with(@image).and_return(false)
        do_post
      end

      it "should set the flash error" do
        do_post
        flash[:error].should == "Could not create image"
      end

      it "should redirect to the new page for the image" do
        do_post
        response.should redirect_to(new_admin_article_image_path(@article))
      end

    end
    
  end

  describe "DELETE 'destroy' - /admin/articles/SKU/images/id" do
    before(:each) do
      @params = @params.merge( :id => "3" )
      @image = mock_model(ArticleImage, :to_param => 3)
      @image.stub!(:destroy).and_return(true)
      ArticleImage.stub!(:find).and_return(@image)
    end

    def do_delete
      delete :destroy, @params
    end

    describe "succesfully" do

      it "should find the image" do
        ArticleImage.should_receive(:find).at_least(1).times.with(@params[:id]).and_return(@image)
        do_delete
      end

      it "should delete the image" do
        @image.should_receive(:destroy).and_return(true)
        do_delete
      end

      it "should set the flash notice" do
        do_delete
        flash[:notice].should == "Image Deleted"
      end

      it "should redirect to the edit page for the article" do
        do_delete
        response.should redirect_to(edit_admin_article_path(@article))
      end

    end

    describe "unsuccessfully" do

      before(:each) do
        @image.stub!(:destroy).and_return(false)
      end

      it "should not delete the image" do
        @image.should_receive(:destroy).and_return(false)
        do_delete
      end

      it "should set the flash error" do
        do_delete
        flash[:error].should == "Could not delete image"
      end

      it "should redirect to the edit page for the article" do
        do_delete
        response.should redirect_to(edit_admin_article_path(@article))
      end

    end

  end

end
