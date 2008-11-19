require File.dirname(__FILE__) + '/../spec_helper'

module OrderSpecHelper

  def valid_order_attributes
    {
      :name => "Bob",
      :address => "One Tree Hill\nNew Road",
      :postcode => "237995"
    }
  end

end

describe Order do

  include OrderSpecHelper

  before(:each) do
    @order = Order.new
  end

  it "should be valid" do
    @order.attributes = valid_order_attributes
    @order.should be_valid
  end
  
  it "should have many dependant CartItems" do
    @order.attributes = valid_order_attributes
    @order.should have_many(:items)
  end

  it "should belong to a user" do
    @order.attributes = valid_order_attributes
    @order.should belong_to(:user)
  end
  
  it "should have an address" do
    @order.should validate_presence_of(:address)
    @order.attributes = valid_order_attributes.except(:address)
    @order.should have_at_least(1).errors_on(:address)
  end
  
  it "should have a postcode" do
    @order.should validate_presence_of(:postcode)
    @order.attributes = valid_order_attributes.except(:postcode)
    @order.should have_at_least(1).errors_on(:postcode)
  end

  it "should have a total value" do
    @line_item1 = LineItem.new({:name => "Item1", :price => 23.99, :quantity => 2})
    @line_item2 = LineItem.new({:name => "Item2", :price => 15.00, :quantity => 1})
    @order.items << @line_item1 << @line_item2

    @order.value.should be_close(62.98, 0.001)
  end
  
  it "should have a status of 'PENDING' set if not set on initialisation" do
    @order.attributes = valid_order_attributes
    @order.status.should == nil
    @order.save
    @order.status.should == "PENDING"
  end
  
  it "should only allow statuses of PENDING, PAID, SHIPPED and CANCELLED" do
    @order.attributes = valid_order_attributes.except(:status)
    @order.status = "PENDING"
    @order.should be_valid
    @order.status = "PAID"
    @order.should be_valid
    @order.status = "SHIPPED"
    @order.should be_valid
    @order.status = "CANCELLED"
    @order.should be_valid
    @order.status = "NONSENSE"
    @order.should have_at_least(1).errors_on(:status)
  end

  it "should be set to 'shipped' when shipped" do
    @order.attributes = valid_order_attributes
    @order.save
    @order.status.should == "PENDING"
    @order.shipped?.should == false
    @order.ship_it
    @order.status.should == "SHIPPED"
    @order.shipped?.should == true
  end

  it "should return true when asked if it is a pending order" do
    @order.attributes = valid_order_attributes
    @order.save
    @order.pending?.should == true
    @order.status.should == "PENDING"
  end
  
  # it "should have a transaction ref"
  # it "should have a country"

end

describe Order, "created from cart object" do

  include OrderSpecHelper

  before(:each) do
    @cart_item1 = mock_model(CartItem, :name => "Item1", :price => 23.99, :quantity => 2, :cart_id => 1, :sku => "SKU1")
    @cart_item2 = mock_model(CartItem, :name => "Item2", :price => 15.00, :quantity => 1, :cart_id => 1, :sku => "SKU2")
    @line_item1 = LineItem.new({:name => "Item1", :price => 23.99, :quantity => 2, :sku => "SKU1"})
    @line_item2 = LineItem.new({:name => "Item2", :price => 15.00, :quantity => 1, :sku => "SKU2"})
    
    LineItem.stub!(:new_from_cart_item).and_return(@line_item1, @line_item2)
        
    @cart = mock_model(Cart, :id => 1, :items => [@cart_item1, @cart_item2])
    @cart.stub!(:empty?).and_return(false)
    
  end

  it "should create new order from a cart object" do
    @cart.should_receive(:empty?).and_return(false)
    LineItem.should_receive(:new_from_cart_item).with(@cart_item1).and_return(@line_item1)
    LineItem.should_receive(:new_from_cart_item).with(@cart_item2).and_return(@line_item2)
    
    @order = Order.new_from_cart(@cart, valid_order_attributes)
    @order.save
    
    Order.find(@order).should_not be_nil
    @order.items.should have(2).items
  end

  it "should not allow a new order from a empty cart" do
    invalid_cart = mock_model(Cart, :id => 1, :items => [])
    invalid_cart.should_receive(:empty?).and_return(true)
    @order = Order.new_from_cart(invalid_cart, valid_order_attributes)
    @order.should be_nil
  end
  
end


describe Order, "class methods" do

  include OrderSpecHelper

  before(:each) do
    @order_pending = Order.new
    @order_pending.attributes = valid_order_attributes.merge({:status => "PENDING"})
    @order_pending.save
    Order.record_timestamps = false # to set updated_at manually
    @order_paid = Order.new
    @order_paid.attributes = valid_order_attributes.merge({:status => "PAID", :updated_at => Time.now-1.day, :user_id => 1})
    @order_paid.save
    @order_paid2 = Order.new
    @order_paid2.attributes = valid_order_attributes.merge({:status => "PAID", :updated_at => Time.now-2.days, :user_id => 1})
    @order_paid2.save
    @order_shipped = Order.new
    @order_shipped.attributes = valid_order_attributes.merge({:status => "SHIPPED", :updated_at => Time.now-1.day, :user_id => 2})
    @order_shipped.save
    @order_shipped2 = Order.new
    @order_shipped2.attributes = valid_order_attributes.merge({:status => "SHIPPED", :updated_at => Time.now-5.days, :user_id => 1})
    @order_shipped2.save
    Order.record_timestamps = true
    @order_cancelled = Order.new
    @order_cancelled.attributes = valid_order_attributes.merge({:status => "CANCELLED"})
    @order_cancelled.save
  end

  it "should return pending orders" do
    Order.pending.should == [@order_pending]
  end
  
  it "should return paid orders in age order, oldest first" do
    Order.paid.should == [@order_paid2, @order_paid]
  end
  
  it "should return shipped orders" do
    Order.shipped.should == [@order_shipped, @order_shipped2]
  end
  
  it "should return cancelled orders" do
    Order.cancelled.should == [@order_cancelled]
  end

end# == Schema Info
# Schema version: 20080930130231
#
# Table name: orders
#
#  id                    :integer(11)     not null, primary key
#  country_id            :integer(11)
#  promotion_id          :integer(11)
#  user_id               :integer(11)
#  address               :text
#  discount_multiplier   :decimal(8, 2)   default(1.0)
#  email                 :string(100)
#  name                  :string(255)
#  phone                 :string(20)
#  postcode              :string(255)
#  receive_update        :boolean(1)      default(TRUE)
#  status                :string(255)
#  transaction_reference :string(255)
#  created_at            :datetime
#  updated_at            :datetime

