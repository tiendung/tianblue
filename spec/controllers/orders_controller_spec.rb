require File.dirname(__FILE__) + '/../spec_helper'


describe OrdersController do
  fixtures :users

  before(:each) do
    login_as("quentin")
  end
  
  describe "GET 'show' - /orders/x - " do

    def do_get
      get :show, :id => 1
    end

    before(:each) do
      @order = mock_model(Order)
      @item1 = mock_model(LineItem)
      @item2 = mock_model(LineItem)
      @order.stub!(:items).and_return([@item1, @item2])
      @order.stub!(:user).and_return(users(:quentin))
      Order.stub!(:find).with("1").and_return(@order)
    end

    describe "with a valid order owned by the current_user" do
      
      it "should try and find the order and succeed" do
        Order.should_receive(:find).with("1").and_return(@order)
        do_get
      end
      it "should check the order is owned by the current user and succeed" do
        @order.should_receive(:user).and_return(users(:quentin))
        do_get
      end
      it "should assign @order to the found order for the view" do
        do_get
        assigns[:order].should == @order
      end
      it "should assign @items to the line_items of the order for the view" do
        @order.should_receive(:items).and_return([@item1, @item2])
        do_get
        assigns[:items].should == [@item1, @item2]
      end
      
    end

    describe "with a valid order NOT owned by the current_user" do

      before(:each) do
        @order.stub!(:user).and_return(users(:aaron))
      end

      it "should try and find the order and succeed" do
        Order.should_receive(:find).with("1").and_return(@order)
        do_get
      end
      it "should check the order is owned by the current user and get the wrong user" do
        @order.should_receive(:user).and_return(users(:aaron))
        do_get
      end
      it "should redirect to orders index" do
        do_get
        response.should be_redirect
        response.should redirect_to(orders_path)
      end

    end

    describe "with a invalid order" do

      before(:each) do
        Order.stub!(:find).with("1").and_return(nil)
      end

      it "should try and find the order and fail" do
        Order.should_receive(:find).with("1").and_return(nil)
        do_get
      end
      it "should redirect to orders index" do
        do_get
        response.should be_redirect
        response.should redirect_to(orders_path)
      end
        
    end

  end
  
  # describe "GET 'index' - /orders - " do
  # 
  #   before(:each) do
  #     @order1 = mock_model(Order)
  #     @order2 = mock_model(Order)
  #     @orders = [@order1, @order2]
  #     
  #     users(:quentin).stub!(:orders).and_return(@orders)
  #   end
  # 
  #   def do_get
  #     get :index
  #   end
  # 
  #   describe "show orders for current user" do
  #     it "should try and find the orders and succeed" do
  #       # users(:quentin).should_receive(:orders).and_return(@orders)
  #       do_get
  #       assigns[:orders].should == @orders
  #     end
  #   end
  # 
  # end

  describe "GET new - '/orders/new' (/checkout) - " do

    before(:each) do
      @item1 = mock_model(CartItem, :id => 1)
      @item2 = mock_model(CartItem, :id => 2)

      @cart = mock_model(Cart, :id => 1000)
      @cart.stub!(:items).and_return([@item1, @item2])
      @cart.stub!(:empty?).and_return(false)

      Cart.stub!(:find_or_create_by_id).and_return(@cart)
      session[:cart] = 1000
    end

    def do_get
      get :new
    end

    it "should find the current cart" do
      Cart.should_receive(:find_or_create_by_id).at_least(1).times.with(session[:cart]).and_return(@cart)
      do_get
    end
    it "should check for an empty cart" do
      @cart.should_receive(:empty?).and_return(false)
      do_get
    end
    it "should set page title to Checkout" do
      do_get
      assigns[:page_title].should == "Checkout"
    end
    it "should set cart variable" do
      do_get
      assigns[:cart].should == @cart
    end
    it "should set items variable" do
      do_get
      assigns[:items].should == @cart.items
    end
    it "should set a new Order object for entry of an address" do
      Order.should_receive(:new).and_return(mock_model(Order))
      do_get
    end
    it "should render the page" do
      do_get
      response.should be_a_success
    end

  end

  describe "POST 'create' /orders - " do

    before(:each) do
      @params = {
        :order => {
          "name" => "Name",
          "address" => "123 Four Drive",
          "postcode" => "67890"
        }
      }
      @item1 = mock_model(CartItem, :id => 1)
      @item2 = mock_model(CartItem, :id => 2)

      @cart = mock_model(Cart, :id => 1000)
      @cart.stub!(:items).and_return([@item1, @item2])
      @cart.stub!(:empty?).and_return(false)
      @cart.stub!(:destroy).and_return(true)

      Cart.stub!(:find_or_create_by_id).and_return(@cart)
      session[:cart] = 1000

      @order = mock_model(Order, :to_param => 23)
      @order.stub!(:user=).with(users(:quentin)).and_return(@order)
      @order.stub!(:save).and_return(true)
      Order.stub!(:new_from_cart).with(@cart, @params[:order]).and_return(@order)
    end

    def do_post
      post :create, @params
    end

   it "should find the current cart" do
      Cart.should_receive(:find_or_create_by_id).at_least(1).times.with(session[:cart]).and_return(@cart)
      do_post
    end
    it "should check for an empty cart" do
      @cart.should_receive(:empty?).and_return(false)
      do_post
    end
    it "should set cart variable" do
      do_post
      assigns[:cart].should == @cart
    end
    it "should assign the order to a variable" do
      do_post
      assigns[:order].should == @order
    end
    it "should redirect to the order page" do
      do_post
      response.should be_redirect
      response.should redirect_to(order_path(@order))
    end
    it "should create the order from the cart" do
      Order.should_receive(:new_from_cart).with(@cart, @params[:order]).and_return(@order)
      do_post
    end
    it "should save the order" do
      @order.should_receive(:save).and_return(true)
      do_post
    end
    it "should empty the cart" do
      @cart.should_receive(:destroy).and_return(true)
      do_post
    end

    describe "fail to create a new order with an empty cart" do

      before(:each) do
        @cart.stub!(:empty?).and_return(true)
      end

      def do_post
        post :create, @params
      end

      it "should find empty cart" do
        @cart.should_receive(:empty?).and_return(true)
        do_post
      end
      it "should redirect to empty cart page" do
        do_post
        response.should be_redirect
        response.should redirect_to(cart_path)
      end
      it "should show error message" do
        do_post
        flash[:error].should == "Cannot checkout with an empty cart!"
      end

    end

  end

  
  describe "POST 'payment_received' - /orders/payment_received - " do

    before(:each) do
      @params = {
        :cartId => "1",
        :transId => "WORLDPAY12",
        :transStatus => "Y" # successfully authorised
      }
      @order = mock_model(Order, :id => 1, :to_param => 1, :transaction_ref => nil, :items=> [@item1, @item2])
      Order.stub!(:find).with(@params[:cartId]).and_return(@order)
      
      @item1 = mock_model(LineItem)
      @item2 = mock_model(LineItem)
      
      @product1 = mock_model(Product)
      @product2 = mock_model(Product)
    end

    def do_post
      post :payment_received, @params
    end

    describe "with a successful payment and valid order" do

      before(:each) do
        @order.stub!(:transaction_reference=).and_return(@order)
        @order.stub!(:status=).and_return(@order)
        @order.stub!(:save).and_return(true)
      end
      
      it "should check payment was successful" do
        do_post
        params[:transStatus].should == "Y"
      end
      
      it "should check for corresponding order in the database" do
        Order.should_receive(:find).with(@params[:cartId]).and_return(@order)
        do_post
        assigns[:order].should == @order
      end
      it "should assign order as paid" do
        @order.should_receive(:status=).with("PAID").and_return(@order)
        do_post
      end
      it "should assign worldpay transaction ref to order" do
        @order.should_receive(:transaction_reference=).with("WORLDPAY12").and_return(@order)
        do_post
      end
      it "should reduce the stock levels of each item in the order"

      it "should save the order" do
        @order.should_receive(:save).and_return(true)
        do_post
      end
      it "should respond with a 200 header" do
        do_post
        response.should be_success
      end
    
    end

    describe "with unsuccessful payment" do
      before(:each) do
        @params[:transStatus] = "C"
        @order.stub!(:transaction_reference=).and_return(@order)
        @order.stub!(:status=).and_return(@order)
        @order.stub!(:save).and_return(true)
      end

      it "should check payment was successful" do
        do_post
        params[:transStatus].should == "C"
      end
      it "should assign order as CANCELLED" do
        @order.should_receive(:status=).with("CANCELLED").and_return(@order)
        do_post
      end
      it "should redirect to order page" do
        do_post
        response.should be_redirect
        response.should redirect_to(order_path(@order))
      end

    end

  end
  
end