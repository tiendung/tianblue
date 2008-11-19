require File.dirname(__FILE__) + '/../spec_helper'

describe CartItem do
  before(:each) do
    @cart_item = CartItem.create({
      :name => "Item",
      :price => 20.20,
      :sku => "ABCD",
      :quantity => 20
    })
  end

  it "should be valid" do
    @cart_item.should be_valid
  end
  
  it "should belong to cart" do
    @cart_item.should belong_to(:cart)
  end
  
  it "should have a name" do
    @cart_item.should validate_presence_of(:name)
    @cart_item.name = nil
    @cart_item.should have_at_least(1).errors_on(:name)
  end

  it "should have a sku" do
    @cart_item.should validate_presence_of(:sku)
    @cart_item.sku = nil
    @cart_item.should have_at_least(1).errors_on(:sku)
  end


  it "should have a price" do
    @cart_item.should validate_presence_of(:price)
    @cart_item.price = nil
    @cart_item.should have_at_least(1).errors_on(:price)
  end

  it "should have a quantity" do
    @cart_item.should validate_presence_of(:quantity)
    @cart_item.quantity = nil
    @cart_item.should have_at_least(1).errors_on(:quantity)
  end

  
end  

describe "CartItem from a StockUnit" do

  before(:each) do
    @cart_item = CartItem.new_from_stock_unit( mock_model(StockUnit, :name => "Brown Trousers", :price => 23.99, :sku => "ABCD"), 1 )
    CartItem.find_by_name("Brown Trousers").should_not be_nil
  end

  it "should populate name" do
    @cart_item.name.should eql("Brown Trousers")
  end
  
  it "should populate price" do
    @cart_item.price.should be_close(23.99, 0.001)
  end
  
  it "should populate quantity" do
    @cart_item.quantity.should eql(1)
  end

  it "should populate sku" do
    @cart_item.sku.should eql("ABCD")
  end
  
  it "should add to quantity on increment" do
    @cart_item.increment_quantity(1)
    @cart_item.quantity.should eql(2)
    @cart_item.increment_quantity(3)
    @cart_item.quantity.should eql(5)
  end
  
  it "should calculate total price of each item" do
    @cart_item.price.should be_close(23.99, 0.001)
    @cart_item.totalprice.should be_close(23.99, 0.001)
    @cart_item.increment_quantity(1)
    @cart_item.price.should be_close(23.99, 0.001)
    @cart_item.totalprice.should be_close(47.98, 0.001)
  end
  
end

describe "CartItem with invalid" do

  it "should throw an error if not passed a product" do
    lambda { CartItem.new_from_product("Nonsense") }.should raise_error
  end
  
end# == Schema Info
# Schema version: 20080930130231
#
# Table name: cart_items
#
#  id         :integer(11)     not null, primary key
#  cart_id    :integer(11)
#  name       :string(255)
#  price      :decimal(8, 2)   default(0.0)
#  quantity   :integer(11)
#  sku        :string(255)
#  created_at :datetime
#  updated_at :datetime

