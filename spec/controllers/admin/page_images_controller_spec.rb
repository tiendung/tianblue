require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::PageImagesController do
  fixtures :users

  before(:each) do
    login_as("tom")
    @params = {
      :page_id => "1"
    }
    @page = mock_model(Page, :id => 1, :name => "PageName", :image => nil)
    Page.stub!(:find_by_permalink).with(@params[:page_id]).and_return(@page)
  end

  describe "GET 'new' - /admin/pages/SKU/image/new - " do

    before(:each) do
      @image = mock_model(PageImage)
      PageImage.stub!(:new).and_return(@image)
    end

    def do_get
      get :new, @params
    end

    it "should get the page" do
      Page.should_receive(:find_by_permalink).with(@params[:page_id]).and_return(@page)
      do_get
      assigns[:page] = @page
    end

    it "should render" do
      PageImage.should_receive(:new).with(no_args).and_return(@image)
      do_get
      response.should be_success
    end

    it "should set the page title" do
      do_get
      assigns[:page_title].should == "New Image for PageName"
    end

  end

  describe "POST 'create' - /admin/pages/SKU/image - " do

    before(:each) do
      @params = @params.merge(
      :image => {
          "uploaded_data" => "blah"
      })
      @image = mock_model(PageImage)
      @page.stub!(:create_image).with(@params[:image]).and_return(@image)
      @page.stub!(:image).and_return(nil)
    end

    def do_post
      post :create, @params
    end

    describe "successfully" do

      it "should create a new page image and assign the image to the page" do
        @page.should_receive(:create_image).with(@params[:image]).and_return(true)
        do_post
      end
      it "should set the flash notice" do
        do_post
        flash[:notice].should == "Image created successfully"
      end

      it "should redirect to the edit page for the page" do
        do_post
        response.should be_redirect
        response.should redirect_to(edit_admin_page_path(@page))
      end

      # describe "with existing image" do
      # 
      #   before(:each) do
      #     @old_image = mock_model(PageImage, :to_param => 3)
      #     @old_image.stub!(:destroy).and_return(true)
      #     @page.stub!(:image).and_return(@old_image)
      #   end
      # 
      #   it "should find any existing image" do
      #     @page.should_receive(:image).and_return(@old_image)
      #     do_post
      #   end
      #   it "should delete any existing image" do
      #     @old_image.should_receive(:destroy).and_return(true)
      #     do_post
      #   end
      # 
      # end
      # 
    end

    describe "unsuccessfully" do
      before(:each) do
        @page.stub!(:create_image).with(@params[:image]).and_return(false)
      end

      it "should fail to assign the image to the page" do
        @page.should_receive(:create_image).with(@params[:image]).and_return(false)
        do_post
      end

      it "should set the flash error" do
        do_post
        flash[:error].should == "Could not create image"
      end

      it "should redirect to the new page for the image" do
        do_post
        response.should redirect_to(new_admin_page_image_path(@page))
      end

    end

  end

  describe "DELETE 'destroy' - /admin/pages/SKU/image/id" do
    before(:each) do
      @image = mock_model(PageImage, :to_param => 3)
      @image.stub!(:destroy).and_return(true)
      @page.stub!(:image).and_return(@image)
    end

    def do_delete
      delete :destroy, @params
    end

    describe "succesfully" do

      it "should find the image" do
        @page.should_receive(:image).and_return(@image)
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

      it "should redirect to the edit page for the page" do
        do_delete
        response.should redirect_to(edit_admin_page_path(@page))
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

      it "should redirect to the edit page for the page" do
        do_delete
        response.should redirect_to(edit_admin_page_path(@page))
      end

    end

  end

end