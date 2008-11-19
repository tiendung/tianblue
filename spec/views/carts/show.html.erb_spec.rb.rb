require File.dirname(__FILE__) + '/../../spec_helper'

describe "/cart display with items" do
  before(:each) do
    
    @cart_item1 = mock_model CartItem, :name => "Brown Trousers", :price => 23.99, :quantity => 2
    @cart_item2 = mock_model CartItem, :name => "Yellow Shirt", :price => 15.00, :quantity => 1
    @cart_items = [@cart_item1, @cart_item2]
    @cart = mock_model( Cart, :to_param => "1", :items => @cart_items )
    @cart.stub!(:price).and_return(62.98)
    @cart.stub!(:empty?).and_return(false)
    
    assigns[:cart] = @cart
    assigns[:cart_items] = @cart.items
    
    render 'carts/show'
  end
    
  it "should display name" do
    response.should have_tag('h1', "Shopping Cart")
  end
  
  it "should display names of all the items" do
    response.should have_tag('table tbody tr th.text', /Brown Trousers/)
    response.should have_tag('table tbody tr+tr th.text', /Yellow Shirt/)
  end

  it "should display prices of all the items" do
    response.should have_tag('table tbody tr td.num', "$23.99")
    response.should have_tag('table tbody tr+tr td.num', "$15.00")
  end

  it "should display prices of all the items" do
    response.should have_tag('table tbody tr td+td.num', "2")
    response.should have_tag('table tbody tr+tr td+td.num', "1")
  end
  
  # it "should have buttons to remove cartitems" do
  #   response.should have_tag('form[action=?][method=?]', cart_item_path(@cart_item1), :post) do
  #     with_tag('button', "Remove")
  #   end
  #   response.should have_tag('form[action=?][method=?]', cart_item_path(@cart_item2), :post) do
  #     with_tag('button', "Remove")
  #   end
  # end

  it "should display cart total" do
    response.should have_tag('div.price p', "Total Cost: $62.98")
  end

  it "should display empty cart button" do
    response.should have_tag('table tfoot tr td form[action=?]', cart_path ) do
      with_tag('input[type=hidden][name=?][value=?]', "_method", "delete")
      with_tag('input[type=submit][value=?]', "Empty Cart")
    end
  end
  
  it "should display a checkout link" do
    response.should have_tag('a[href=?]', checkout_url, /Checkout/)
  end
  
end

describe "/cart display with no items" do
  before(:each) do
    
    @cart = mock_model( Cart, :to_param => "1", :items => nil )
    @cart.stub!(:empty?).and_return(true)
    
    assigns[:cart] = @cart
    assigns[:items] = @cart.items
    
    render 'carts/show'
  end
    
  it "should display message in place of cart total" do
    response.should_not have_tag('h2', /Total Cost/)
    response.should have_tag('h2', "You have no items in your cart")
  end
  
  it "should display a checkout link" do
    response.should_not have_tag('a[href=?]', checkout_url, "Checkout")
  end
  
end