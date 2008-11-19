require File.dirname(__FILE__) + '/../spec_helper'

describe LineItem do
  before(:each) do
    @line_item = LineItem.create({
      :name => "Item",
      :price => 20.20,
      :sku => "ABCD",
      :quantity => 20
    })
  end

  it "should be valid" do
    @line_item.should be_valid
  end
  
  it "should belong to an order" do
    @line_item.should belong_to(:order)
  end
  
  it "should have a name" do
    @line_item.should validate_presence_of(:name)
    @line_item.name = nil
    @line_item.should have_at_least(1).errors_on(:name)
  end

  it "should have a sku" do
    @line_item.should validate_presence_of(:sku)
    @line_item.sku = nil
    @line_item.should have_at_least(1).errors_on(:sku)
  end


  it "should have a price" do
    @line_item.should validate_presence_of(:price)
    @line_item.price = nil
    @line_item.should have_at_least(1).errors_on(:price)
  end

  it "should have a quantity" do
    @line_item.should validate_presence_of(:quantity)
    @line_item.quantity = nil
    @line_item.should have_at_least(1).errors_on(:quantity)
  end
  
end

describe "LineItem from a CartItem" do

  before(:each) do
    @line_item = LineItem.new_from_cart_item( mock_model(CartItem, :name => "CartItem", :price => 23.99, :quantity => 2, :sku => "ABCD") )
    LineItem.find_by_name("CartItem").should_not be_nil
  end

  it "should populate name" do
    @line_item.name.should eql("CartItem")
  end
  
  it "should populate price" do
    @line_item.price.should be_close(23.99, 0.001)
  end

  it "should populate sku" do
    @line_item.sku.should eql("ABCD")
  end
  
  it "should populate quantity" do
    @line_item.quantity.should eql(2)
  end
    
  it "should calculate total price of each item" do
    @line_item.price.should be_close(23.99, 0.001)
    @line_item.totalprice.should be_close(47.98, 0.001)
  end
  
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: line_items
#
#  id         :integer(11)     not null, primary key
#  order_id   :integer(11)
#  name       :string(255)
#  price      :decimal(8, 2)   default(0.0)
#  quantity   :integer(11)
#  sku        :string(255)
#  created_at :datetime
#  updated_at :datetime

