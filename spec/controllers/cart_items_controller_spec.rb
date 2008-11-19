require File.dirname(__FILE__) + '/../spec_helper'

describe CartItemsController do

  describe "PUT 'create' - /cart_items" do

    before(:each) do
      @params = {
        :cart_item => {
          "sku" => "sku-sz",
          "quantity" => "2"
        }
      }
      @stock_unit = mock_model(StockUnit, :id => 1, :name => "Product (size)", :price => 13.00, :sku => "sku-sz")
      StockUnit.stub!(:find_by_sku).with("sku-sz").and_return(@stock_unit)

      @cart = mock_model(Cart, :id => 10)
      @cart.stub!(:add_stock_unit).and_return(true)
      Cart.stub!(:find_or_create_by_id).and_return(@cart)
      session[:cart] = 10
      request.env["HTTP_REFERER"] = "/prev/page"
    end

    def do_post
      post :create, @params
    end

    it "should get the StockUnit" do
      StockUnit.should_receive(:find_by_sku).with("sku-sz").and_return(@stock_unit)
      do_post
      assigns[:stock_unit].should == @stock_unit
    end

    it "should get the cart from the session" do
      Cart.should_receive(:find_or_create_by_id).with(session[:cart]).at_least(1).times.and_return(@cart) 
      do_post  
      assigns[:cart].should == @cart
    end

    it "should add the item to the cart" do
      @cart.should_receive(:add_stock_unit).with(@stock_unit, @params[:cart_item]["quantity"]).and_return(true)
      do_post
    end

    it "should redirect to the previous page" do
      do_post
      response.should be_redirect
      response.should redirect_to("/prev/page")
    end
  end

end
