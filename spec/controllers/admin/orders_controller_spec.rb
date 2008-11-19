require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::OrdersController do
  fixtures :users

  before(:each) do
    login_as("tom")
  end

  describe "GET 'index' - /admin/orders -" do

    def do_get
      get :index
    end

    before(:each) do
      @order1 = mock_model(Order, :id => 1, :name => "Order1", :status => 'PENDING')
      @order2 = mock_model(Order, :id => 2, :name => "Order2", :status => 'PAID')
      @order3 = mock_model(Order, :id => 3, :name => "Order3", :status => 'PAID')
      @order4 = mock_model(Order, :id => 4, :name => "Order4", :status => 'SHIPPED')
      @order5 = mock_model(Order, :id => 4, :name => "Order5", :status => 'SHIPPED')
      @order6 = mock_model(Order, :id => 4, :name => "Order6", :status => 'CANCELLED')
      Order.should_receive(:pending).and_return([@order1])
      Order.should_receive(:paid).and_return([@order2, @order3])
      Order.should_receive(:shipped).and_return([@order4, @order5])
      Order.should_receive(:cancelled).and_return([@order6])
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end

    it "should list unpaid orders" do
      do_get
      assigns[:pending_orders].should == [@order1]
    end

    it "should list unpaid orders" do
      do_get
      assigns[:paid_orders].should == [@order2, @order3]
    end

    it "should list unpaid orders" do
      do_get
      assigns[:shipped_orders].should == [@order4, @order5]
    end

    it "should list unpaid orders" do
      do_get
      assigns[:cancelled_orders].should == [@order6]
    end

    it "should set title to Orders" do
      do_get
      assigns[:page_title].should == "Orders"
    end

  end
  
  describe "GET 'show' - /admin/orders/xx - " do
    
    before(:each) do
      @item1 = mock_model(LineItem)
      @item2 = mock_model(LineItem)
      @order = mock_model(Order, :id => 1, :name => "Order1", :status => 'PENDING', :items=>[@item1, @item2])
      @order.stub!(:items).and_return([@item1, @item2])
      Order.stub!(:find).with("1").and_return(@order)
    end
    
    def do_get
      get :show, :id => 1
    end
    
    describe "with a valid order" do
    
      it "should get the order" do
        Order.should_receive(:find).with("1").and_return(@order)
        do_get
      end
      it "should assign found order to @order for the view" do
        do_get
        assigns[:order].should == @order
      end
      it "should assign @items to the view" do
        @order.should_receive(:items).and_return([@item1, @item2])
        do_get
        assigns[:items].should == [@item1, @item2]
      end
      
      
    end
    
  end

  describe "PUT 'update' - /admin/orders/xx - " do

    before(:each) do
      @params = {
        :id => "1",
        :order => { 
          "status" => "PAID"
        }
      }
      @order = mock_model(Order, :id => 1, :name => "Order1", :status => 'PENDING')
      @order.stub!(:status=).and_return(@order)
      @order.stub!(:save).and_return(true)
      Order.stub!(:find).with("1").and_return(@order)
    end
    
    def do_put
      put :update, @params
    end

    describe "successfully updates the status" do
      it "should find the order" do
        Order.should_receive(:find).with("1").and_return(@order)
        do_put
      end
      it "should update status" do
        @order.should_receive(:status=).with(@params[:order]["status"]).and_return(@order)
        do_put
      end
      it "should save the order" do
        @order.should_receive(:save).and_return(true)
        do_put
      end
      it "should redirect to the orders index" do
        do_put
        response.should be_redirect
        response.should redirect_to(admin_orders_path)
      end
      it "should set the flash notice" do
        do_put
        flash[:notice].should == "Order #{@order.id} set to #{@params[:order]['status']}" 
      end
    end

    describe "fails to update" do
      before(:each) do
        @order.stub!(:save).and_return(false)
      end
      
      it "should redirect to the individual order page" do
        do_put
        response.should be_redirect
        response.should redirect_to(admin_order_path(@order))
      end
      it "should set flash error" do
        do_put
        flash[:error].should == "Could not update order status" 
      end
    end

  end

  describe "DELETE 'destroy' - /admin/orders/xx" do
    before(:each) do
      @params = {
        :id => "1",
      }
      @order = mock_model(Order, :id => 1, :name => "Order1", :status => 'PENDING', :pending? => true)
      Order.stub!(:find).with("1").and_return(@order)
      @order.stub!(:destroy).and_return(true)
    end

    def do_delete
      delete :destroy, @params
    end

    describe "succesfully" do
      
      it "should find the order" do
        Order.should_receive(:find).and_return(@order)
        do_delete
      end
      it "should check status" do
        @order.should_receive(:pending?).and_return(true)
        do_delete
      end

      it "should delete the image" do
        @order.should_receive(:destroy).and_return(true)
        do_delete
      end

      it "should set the flash notice" do
        do_delete
        flash[:notice].should == "Order Deleted"
      end

      it "should redirect to the orders page" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_orders_path)
      end

    end

    describe "not destroy because item is not pending" do
      before(:each) do
        @order.stub!(:pending?).and_return(false)
      end
      
      it "should not destroy item" do
        @order.should_not_receive(:destroy)
        do_delete
      end
      it "should set flash notice " do
        do_delete
        flash[:notice].should == "Order not PENDING, can not delete"
      end
      it "should redirect to show order" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_order_path(@order))
      end
    end

    describe "unsuccessfully with error" do

      before(:each) do
        @order.stub!(:destroy).and_return(false)
      end

      it "should not delete the image" do
        @order.should_receive(:destroy).and_return(false)
        do_delete
      end
      it "should set the flash error" do
        do_delete
        flash[:error].should == "Could not delete order"
      end
      it "should redirect to the show page for the order" do
        do_delete
        response.should redirect_to(admin_order_path(@order))
      end

    end

    describe "with a non-valid order" do
      before(:each) do
        Order.stub!(:find).and_return(nil)
      end
      it "should set the flash error" do
        do_delete
        flash[:error].should == "Order does not exist. Cannot delete"
      end
      it "should redirect to the orders page" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_orders_path)
      end
    end

  end

end
