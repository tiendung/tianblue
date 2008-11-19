require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::CategoryImagesController do
  fixtures :users
  
  before(:each) do
    @params = {
      :category_id => "name"
    }
    @category = mock_model(Category, :id => 1, :name => "CategoryName", :image => nil)
    Category.stub!(:find_by_name).with(@params[:category_id]).and_return(@category)

    login_as("tom")
  end

  describe "GET 'new' - /admin/categories/SKU/image/new - " do

    before(:each) do
      @image = mock_model(CategoryImage)
      CategoryImage.stub!(:new).and_return(@image)
    end

    def do_get
      get :new, @params
    end

    it "should get the category" do
      Category.should_receive(:find_by_name).with(@params[:category_id]).and_return(@category)
      do_get
      assigns[:category] = @category
    end

    it "should render" do
      CategoryImage.should_receive(:new).with(no_args).and_return(@image)
      do_get
      response.should be_success
    end

    it "should set the page title" do
      do_get
      assigns[:page_title].should == "New Image for CategoryName"
    end

  end
  
  describe "POST 'create' - /admin/categories/SKU/image - " do

    before(:each) do
      @params = @params.merge(
      :image => {
          "uploaded_data" => "blah"
      })
      @image = mock_model(CategoryImage)
      @category.stub!(:create_image).with(@params[:image]).and_return(@image)
      @category.stub!(:image).and_return(nil)
    end

    def do_post
      post :create, @params
    end
    
    describe "successfully" do
      
      it "should create a new category image and assign the image to the category" do
        @category.should_receive(:create_image).with(@params[:image]).and_return(true)
        do_post
      end
      it "should set the flash notice" do
        do_post
        flash[:notice].should == "Image created successfully"
      end

      it "should redirect to the edit page for the category" do
        do_post
        response.should be_redirect
        response.should redirect_to(edit_admin_category_path(@category))
      end
      
      # describe "with existing image" do
      # 
      #   before(:each) do
      #     @old_image = mock_model(CategoryImage, :to_param => 3)
      #     @old_image.stub!(:destroy).and_return(true)
      #     @category.stub!(:image).and_return(@old_image)
      #   end
      # 
      #   it "should find any existing image" do
      #     @category.should_receive(:image).and_return(@old_image)
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
        @category.stub!(:create_image).with(@params[:image]).and_return(false)
      end

      it "should fail to assign the image to the category" do
        @category.should_receive(:create_image).with(@params[:image]).and_return(false)
        do_post
      end

      it "should set the flash error" do
        do_post
        flash[:error].should == "Could not create image"
      end

      it "should redirect to the new page for the image" do
        do_post
        response.should redirect_to(new_admin_category_image_path(@category))
      end

    end
    
  end

  describe "DELETE 'destroy' - /admin/categories/SKU/image/id" do
    before(:each) do
      @image = mock_model(CategoryImage, :to_param => 3)
      @image.stub!(:destroy).and_return(true)
      @category.stub!(:image).and_return(@image)
    end

    def do_delete
      delete :destroy, @params
    end

    describe "succesfully" do

      it "should find the image" do
        @category.should_receive(:image).and_return(@image)
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

      it "should redirect to the edit page for the category" do
        do_delete
        response.should redirect_to(edit_admin_category_path(@category))
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

      it "should redirect to the edit page for the category" do
        do_delete
        response.should redirect_to(edit_admin_category_path(@category))
      end

    end

  end

end

