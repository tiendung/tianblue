require File.dirname(__FILE__) + '/../spec_helper'

describe CartsController do

  it "should use CartController" do
    controller.should be_an_instance_of(CartsController)
  end

end

describe CartsController, "show the existing cart" do

  before(:each) do
    @item1 = mock_model(CartItem, :id => 1)
    @item2 = mock_model(CartItem, :id => 2)

    @cart = mock_model(Cart, :id => 1)
    @cart.stub!(:items).and_return([@item1, @item2])

    Cart.stub!(:find).and_return(@cart)
    session[:cart] = 1000
  end

  def do_get
    get :show
  end

  it "should render show template" do
    do_get
    response.should render_template('show')
  end

  it "should find a cart if it exists" do
    # find with the cart items : one trip to the db!
    Cart.should_receive(:find).with(session[:cart], {:include => :items}).and_return(@cart)
    do_get
  end

  it "should get all the items in the cart" do
    @cart.should_receive(:items).and_return([@item1, @item2])
    do_get
  end
  
  it "should assign cart items to a variable" do
    do_get
    assigns[:cart_items].should == [@item1,@item2]
  end

end

describe CartsController, "create a new cart where one no longer exists" do

  before(:each) do
    Cart.stub!(:create).and_return(mock_model(Cart, :id => 40000))
    session[:cart] = 12000
    Cart.stub!(:find).with(session[:cart], {:include => :items}).and_return(nil)
  end

  def do_get
    get :show
  end

  it "should look in the session for a cart id and then find from DB" do
    Cart.should_receive(:find).with(session[:cart], {:include => :items}).and_return(nil)
    do_get
  end

  it "should create a new Cart" do
    Cart.should_receive(:create).and_return(mock_model(Cart))
    do_get
  end
  
  it "should set the cart id in the sessions" do
    do_get
    session[:cart].should == 40000
  end

  it "should set the cart items variable" do
    do_get
    assigns[:cart_items].should == nil
  end

end

describe CartsController, "create a new cart where no session variable set exists" do

  before(:each) do
    Cart.stub!(:create).and_return(mock_model(Cart, :id => 40000))
    session[:cart] = nil
  end
  
  def do_get
    get :show
  end
  
  it "should not look in the session for a cart" do
    Cart.should_not_receive(:find)
    do_get
  end
  
  it "should create a new Cart" do
    Cart.should_receive(:create).and_return(mock_model(Cart))
    do_get
  end

  it "should set the cart id in the sessions" do
    do_get
    session[:cart].should == 40000
  end

  it "should set the cart items variable" do
    do_get
    assigns[:cart_items].should == nil
  end

end

describe CartsController, "empty existing cart (destroy in db)" do

  before(:each) do
    @item1 = mock_model(CartItem, :id => 1)
    @item2 = mock_model(CartItem, :id => 2)

    @cart = mock_model(Cart, :id => 1)
    @cart.stub!(:items).and_return([@item1, @item2])

    Cart.stub!(:find).and_return(@cart)
    session[:cart] = 1000
    
    request.env["HTTP_REFERER"] = "/prev/page"
  end
  
  def do_delete
    delete :destroy
  end
  
  it "should look in the session for a cart" do
    Cart.should_receive(:find).with(session[:cart], {:include => :items}).and_return(@cart) 
    do_delete   
  end
  
  it "should delete the cart" do
    Cart.should_receive(:delete).with(1).and_return(true)
    do_delete
  end
  
  it "should delete the cart id from the session" do
    do_delete
    session[:cart].should == nil
  end
  
  it "should redirect to the previous page" do
    do_delete
    response.should be_redirect
    response.should redirect_to("/prev/page")
  end

end

describe CartsController, "empty cart when there is no cart (destroy in db)" do

  before(:each) do
    request.env["HTTP_REFERER"] = "/prev/page"
  end
  
  def do_delete
    delete :destroy
  end
  
  it "should not look in the session for a cart" do
    Cart.should_not_receive(:find)
    do_delete
  end
  
  it "should not try and delete the cart" do
    Cart.should_not_receive(:delete)
    do_delete
  end
  
  it "should redirect to the previous page" do
    do_delete
    response.should be_redirect
    response.should redirect_to("/prev/page")
  end

end