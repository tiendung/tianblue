require File.dirname(__FILE__) + '/../spec_helper'

describe ProductsController do

  before(:each) do
    @product1 = mock_model(Product, :id => 1, :name => "Product1")
    @product2 = mock_model(Product, :id => 2, :name => "Product2")
    @product3 = mock_model(Product, :id => 3, :name => "Product3")
    @product4 = mock_model(Product, :id => 4, :name => "Product4")
    @products = [@product1, @product2, @product3, @product4]
    @cart = mock_model(Cart, :id => 10)
    Cart.stub!(:find).and_return(@cart)
    session[:cart] = 10
  end

  describe "GET 'index' - /products - " do

    before(:each) do
      Product.stub!(:all).and_return(@products)
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

    it "should find all the products" do
      Product.should_receive(:all).and_return(@products)
      do_get
    end
    it "should assign all products to @products" do
      do_get
      assigns[:products].should == @products
    end
    it "should set the title to Products" do
      do_get
      assigns[:page_title].should == "Products"
    end

  end

  describe "GET 'category' - /category/xx - " do

    before(:each) do
      @params = {
        :id => "men"
      }
      @image = mock_model(CategoryImage)
      @category = mock_model(Category, :id=>1, :name=>"CategoryName", :title=>"Title", :to_param=>1, :image => @image)
      Product.stub!(:in_category).with(@params[:id]).and_return(@products)
      Category.stub!(:find_by_name).with(@params[:id]).and_return(@category)
    end

    def do_get
      get :category, @params
    end

    it "should find a cart in database or create one" do
      Cart.should_receive(:find_or_create_by_id).with(10).at_least(1).times.and_return(@cart)
      do_get
    end
    it "should create a new cart" do
      do_get
      assigns[:cart].should_not be_nil
    end

    describe "with valid category and products in that category" do

      it "should find the products by category" do
        Product.should_receive(:in_category).and_return(@products)
        do_get
      end
      it "should assign @products for the view" do
        do_get
        assigns[:products].should == @products
      end
      it "should assign @image" do
        do_get
        assigns[:image].should == @image
      end
      it "should set the page title" do
        do_get
        assigns[:page_title].should == @category.title
      end
      it "should render the index page" do
        do_get
        response.should render_template("index")
      end
      it "should set the page_class to be the category" do
        do_get
        assigns[:page_class].should == @category.name 
        assigns[:page_class].should == "CategoryName"
      end

    end

    describe "with valid category and no products in that category"

    describe "with invalid category" do
      before(:each) do
        Product.stub!(:in_category).with("men").and_return(false)
      end
      it "should redirect to index" do
        do_get
        response.should be_redirect
        response.should redirect_to(products_path)
      end
      
    end

  end

  describe "GET 'show' - /product/xx -" do
    before(:each) do
      @stock_unit1 = mock_model(StockUnit,
        :id => 1,
        :to_param => 1,
        :name => "Brown Trousers (medium)",
        :sku => "sku-m"
      )
      @stock_unit2 = mock_model(StockUnit,
        :id => 2,
        :to_param => 2,
        :name => "Brown Trousers (large)",
        :sku => "sku-l"
      )
      
      @product = mock_model(Product, :id => 1, :name => "Product1", :sku => "SKU", :stock_units => [@stock_unit1, @stock_unit2], :category => mock_model(Category, :name=>"CategoryName"))
      Product.stub!(:find_by_sku).with("SKU").and_return(@product)
      @cart = mock_model(Cart, :id => 10)
      Cart.stub!(:find).and_return(@cart)
      session[:cart] = 10
    end

    def do_get
      get :show, :id => "SKU"
    end

    describe "with valid product" do
      it "should render index template" do
        do_get
        response.should render_template('show')
      end
      it "should call Product with id" do
        do_get
        assigns[:product].should == @product
      end
      it "should set stock_units" do
        do_get
        assigns[:stock_units].should == @product.stock_units
      end
      it "should set the title to the product name" do
        do_get
        assigns[:page_title].should == @product.name
      end
      it "should set the page_class to be the category" do
        do_get
        assigns[:page_class].should == @product.category.name 
        assigns[:page_class].should == "CategoryName"
      end
    end

    describe "with invalid product" do
      before(:each) do
        Product.stub!(:find_by_sku).with("SKU").and_return(nil)
      end

      it "should should not find a product" do
        Product.should_receive(:find_by_sku).with("SKU").and_return(nil)
        do_get
      end
      it "should render index template" do
        do_get
        response.should_not render_template('show')
      end
      it "shouldn't set the page title" do
        do_get
        assigns[:page_title].should be_nil
      end
      it "should redirect to index" do
        do_get
        response.should redirect_to(products_path)
      end
    end

  end


end