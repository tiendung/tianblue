require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::ProductsController do
  fixtures :users

  before(:each) do
    login_as("tom")
  end

  it "should use Admin::ProductsController" do
    controller.should be_an_instance_of(Admin::ProductsController)
  end

  it "should use the admin layout" do
    Admin::ProductsController.should_receive(:layout).with("admin")
    load(RAILS_ROOT + "/app/controllers/admin/products_controller.rb")
  end

  describe "GET 'index' - /admin/products" do
    before(:each) do
      @product = mock_model(Product, :id => 1, :name => "Product")
      @product1 = mock_model(Product, :id => 2, :name => "Product1")
      @product2 = mock_model(Product, :id => 3, :name => "Product2")
      @product3 = mock_model(Product, :id => 4, :name => "Product3")
      @product4 = mock_model(Product, :id => 5, :name => "Product4")
      Product.should_receive(:all).and_return([@product, @product1, @product2, @product3, @product4])
    end

    def do_get
      get :index
    end
    it "should render index template" do
      do_get
      response.should render_template('index')
    end
    it "should list all availible products" do
      do_get
      assigns[:products].should == [@product, @product1, @product2, @product3, @product4]
    end
    it "should set title to Products" do
      do_get
      assigns[:page_title].should == "Products"
    end
  end

  describe "GET 'new' - /admin/products/new" do
    before(:each) do
      Product.stub!(:new).and_return(@product = mock_model(Product))
    end

    def do_get
      get :new
    end

    it "should render" do
      do_get
      response.should be_success
    end
    it "should create a new object" do
      do_get
      assigns[:page_title].should == "New Product"
    end
  end

  describe "POST 'create' - /admin/products" do
    before(:each) do
      @params = {
        :product => { 
          "name" => "Product", 
          "description" => "Product Description",
          "price" => "20.00",
          "quantity" => "10",
          "sku" => "SKU"
        }
      }
      @product = mock_model(User, :id => 1, :name => "Product", :description => "Product Description", :price => 20.00, :quantity => 10, :sku => "SKU")
      @product.stub!(:save).and_return(true)

      Product.stub!(:new).and_return(@product)
    end

    def do_post
      post :create, @params
    end

    describe "successfully" do
      it "should create a new object" do
        Product.should_receive(:new).with(@params[:product]).and_return(@product)
        do_post
      end
      it "should save a new object successfully" do
        @product.should_receive(:save).and_return(true)
        do_post
      end
      it "should set the flash notice" do
        do_post
        flash[:notice].should == "#{params[:product]["name"]} created successfully"
      end
      it "should redirect to admin products page" do
        do_post
        response.should be_redirect
        response.should redirect_to(admin_products_path)
      end
    end

    describe "unsuccessfully" do
      before(:each) do
        @product.stub!(:save).and_return(false)
      end

      it "should not save a new object successfully" do
        @product.should_receive(:save).and_return(false)
        do_post
      end
      it "should set the flash error" do
        do_post
        flash[:error].should == "Could not create"
      end
      it "should redirect to admin products page" do
        do_post
        response.should be_redirect
        response.should redirect_to(new_admin_product_path)
      end
    end

  end

  describe "GET 'edit' - /admin/products/xx/edit" do
  
    before(:each) do
      @product = mock_model(Product,
        :id => 1, 
        :name => "Product",
        :sku => "SKU", 
        :images => [mock_model(ProductImage)],
        :stock_units => [mock_model(StockUnit, :id=>1, :to_param=>"1", :size=>"Medium")]
      )
      Product.stub!(:find_by_sku).with("SKU").and_return(@product)
    end

    def do_get
      get :edit, :id => "SKU"
    end
  
    describe "with valid product" do
      it "should render edit template" do
        do_get
        response.should render_template('edit')
      end
      it "should return referenced product" do
        do_get
        assigns[:product].should == @product
      end
      it "should return referenced products images" do
        do_get
        assigns[:images].should == @product.images
      end
      it "should return referenced products stock units" do
        do_get
        assigns[:stock_units].should == @product.stock_units
      end
      it "should set title to ProductName >> Products" do
        do_get
        assigns[:page_title].should == "Edit Product &#187; Products"
      end
    end

    describe "with invalid product" do
      before(:each) do
        Product.stub!(:find_by_sku).with("SKU").and_return(nil)
      end

      it "should not render edit template" do
        do_get
        response.should_not render_template('edit')
      end
      it "should redirect to index" do
        do_get
        response.should redirect_to(admin_products_path)
      end
    end

  end

  describe "PUT 'update' - /admin/products/xx" do
    before(:each) do
      @params = {
        :id => "SKU",
        :product => {
          "name" => "NewName",
          "price" => "23.99",
          "stock" => "50",
          "sku" => "SKU"
        }
      }
      @product = mock_model(Product, :id => 1, :name => "ProductName")
      @product.stub!(:update_attributes).with(@params[:product]).and_return(true)
      Product.stub!(:find_by_sku).with("SKU").and_return(@product)
    end

    def do_put
      put :update, @params
    end

    describe "successfully" do
      it "should find the product" do
        Product.should_receive(:find_by_sku).with("SKU").and_return(@product)
        do_put
      end
      it "should save updated product" do
        @product.should_receive(:update_attributes).with(@params[:product]).and_return(true)
        do_put
      end
      it "should set the flash" do
        do_put
        flash[:notice].should == "ProductName updated successfully"
      end
      it "should redirect to index" do
        do_put
        response.should redirect_to(admin_products_path)
      end
    end
    
    describe "unsuccessfully" do
      before(:each) do
        @product.stub!(:update_attributes).with(@params[:product]).and_return(false)
      end

      it "should try and save and fail" do
        @product.should_receive(:update_attributes).with(@params[:product]).and_return(false)
        do_put
      end
      it "should redirect to edit" do
        do_put
        response.should redirect_to(edit_admin_product_path(@product))
      end
      it "should set the error flash" do
        do_put
        flash[:error].should == "ProductName could not be updated"
      end
    end
  end

end