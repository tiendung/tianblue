require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::ProductImagesController do
  fixtures :users

  before(:each) do
    login_as("tom")
    @params = {
      :product_id => "SKU"
    }
    @product = mock_model(Product, :id => 1, :to_param => "SKU", :sku => "SKU", :name => "ProductName", :images => [])
    Product.stub!(:find_by_sku).with(@params[:product_id]).and_return(@product)
  end

  describe "GET 'new' - /admin/products/SKU/images/new - " do

    before(:each) do
      @image = mock_model(ProductImage)
      ProductImage.stub!(:new).and_return(@image)
    end

    def do_get
      get :new, @params
    end

    it "should render" do
      ProductImage.should_receive(:new).with(no_args).and_return(@image)
      do_get
      response.should be_success
    end

    it "should get the product" do
      Product.should_receive(:find_by_sku).with(@params[:product_id]).and_return(@product)
      do_get
      assigns[:product] = @product
    end

    it "should set the page title" do
      do_get
      assigns[:page_title].should == "New Image for ProductName"
    end

  end
  
  describe "POST 'create' - /admin/products/SKU/images - " do

    before(:each) do
      @params = @params.merge(
      :image => {
          "uploaded_data" => "blah"
      })
      @image = mock_model(ProductImage)
      @product.images.stub!(:<<).with(@image).and_return(true)
      ProductImage.stub!(:new).and_return(@image)
    end

    def do_post
      post :create, @params
    end
    
    describe "successfully" do
      it "should create a new product image" do
        ProductImage.should_receive(:new).with(@params[:image]).and_return(@image)
        do_post
      end

      it "should get the product" do
        Product.should_receive(:find_by_sku).with(@params[:product_id]).and_return(@product)
        do_post
        assigns[:product] = @product
      end

      it "should assign the image to the product (which saves it)" do
        @product.images.should_receive(:<<).with(@image).and_return(true)
        do_post
      end

      it "should set the flash notice" do
        do_post
        flash[:notice].should == "Image created successfully"
      end

      it "should redirect to the edit page for the product" do
        do_post
        response.should be_redirect
        response.should redirect_to(edit_admin_product_path(@product))
      end
    end

    describe "unsuccessfully" do
      before(:each) do
        @product.images.stub!(:<<).with(@image).and_return(false)
      end

      it "should fail to assign the image to the product" do
        @product.images.should_receive(:<<).with(@image).and_return(false)
        do_post
      end

      it "should set the flash error" do
        do_post
        flash[:error].should == "Could not create image"
      end

      it "should redirect to the new page for the image" do
        do_post
        response.should redirect_to(new_admin_product_image_path(@product))
      end

    end
    
  end

  describe "DELETE 'destroy' - /admin/products/SKU/images/id" do
    before(:each) do
      @params = @params.merge( :id => "3" )
      @image = mock_model(ProductImage, :to_param => 3)
      @image.stub!(:destroy).and_return(true)
      ProductImage.stub!(:find).and_return(@image)
    end

    def do_delete
      delete :destroy, @params
    end

    describe "succesfully" do

      it "should find the image" do
        ProductImage.should_receive(:find).at_least(1).times.with(@params[:id]).and_return(@image)
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

      it "should redirect to the edit page for the product" do
        do_delete
        response.should redirect_to(edit_admin_product_path(@product))
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

      it "should redirect to the edit page for the product" do
        do_delete
        response.should redirect_to(edit_admin_product_path(@product))
      end

    end

  end

end
