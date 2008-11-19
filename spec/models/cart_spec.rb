require File.dirname(__FILE__) + '/../spec_helper'

describe Cart do
  before(:each) do
    @stock_unit1 = mock_model StockUnit, :name => "Brown Trousers", :price => 23.99, :sku => "sku1"
    @stock_unit2 = mock_model StockUnit, :name => "Yellow Shirt", :price => 15.00, :sku => "sku2"
    
    @cart_item1 = mock_model CartItem, :name => "Brown Trousers", :price => 23.99, :quantity => 1, :sku => "sku1"
    @cart_item2 = mock_model CartItem, :name => "Yellow Shirt", :price => 15.00, :quantity => 1, :sku => "sku2"
    @cart_item3 = mock_model CartItem, :name => "Item3", :price => 10.00, :quantity => 3
 
    @cart = Cart.new
  end

  it "should be valid" do
    @cart.should be_valid
  end
  
  it "should have many dependant CartItems" do
    @cart.should have_many(:items)
  end

  it "should initially be empty" do
    @cart.empty?.should be_true
    @cart.size.should eql(0)
  end
  
  it "should find item in cart by name" do
    @cart.items.should_receive(:find_by_sku).with("sku1")
    @cart.find_item_by_sku("sku1")
  end
  
  it "should add the product when it doesn't already exist in the cart" do
   @cart.should_receive(:find_item_by_sku).once.with("sku1").and_return(nil)
   @cart.add_stock_unit(@stock_unit1)
   @cart.items.should have(1).item
  end

  it "should increment quantity when it does find a product" do
    @cart_item1.should_receive(:increment_quantity).once.and_return(2)
    @cart.should_receive(:find_item_by_sku).twice.with("sku1").and_return(nil, @cart_item1)
    @cart.add_stock_unit(@stock_unit1)
    @cart.add_stock_unit(@stock_unit1)
    @cart.items.should have(1).item
  end

  it "should ad a product when a different product is in the cart" do
    @cart.should_receive(:find_item_by_sku).once.with("sku1").and_return(nil)
    @cart.should_receive(:find_item_by_sku).once.with("sku2").and_return(nil)
    @cart.add_stock_unit(@stock_unit1)
    @cart.add_stock_unit(@stock_unit2)
    @cart.items.should have(2).items
  end

  it "should calculate total cart cost" do
    @cart.add_stock_unit(@stock_unit1)
    @cart.add_stock_unit(@stock_unit2)
    @cart.items[0].should_receive(:totalprice).and_return(23.99)
    @cart.items[1].should_receive(:totalprice).and_return(15.00)
    @cart.price.should be_close(38.99, 0.001)
  end
    
  it "should calculate number of items in the cart" do
    @cart.items = [@cart_item1, @cart_item3]
    @cart.items[0].should_receive(:quantity).and_return(1)
    @cart.items[1].should_receive(:quantity).and_return(3)
    @cart.number_of_items.should == 4
  end
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: carts
#
#  id                  :integer(11)     not null, primary key
#  discount_multiplier :decimal(8, 2)   default(1.0)
#  created_at          :datetime
#  updated_at          :datetime

