require File.dirname(__FILE__) + '/../../spec_helper'

describe "/orders" do
  before(:each) do
    @orders = [
      mock_model(Order, :id => 1, :to_param => 1, :value => 10.00, :created_at => Time.now-1.days, :status => "PAID"),
      mock_model(Order, :id => 2, :to_param => 2, :value => 22.00, :created_at => Time.now-2.days, :status => "SHIPPED"),
      mock_model(Order, :id => 3, :to_param => 3, :value => 33.30, :created_at => Time.now-3.days, :status => "SHIPPED")
    ]

    assigns[:orders] = @orders
    assigns[:page_title] = "Your Orders"
    
    render 'orders/index'
  end
  
  it "should display page title products" do
    response.should have_tag('h1', "Your Orders")
  end
  
  it "should show each product in a tabular format" do
    response.should have_tag('table tbody tr', 3)
  end
  it "should show links to the order pages" do
    response.should have_tag('th a[href=?]', order_path(1))
    response.should have_tag('tr+tr th a[href=?]', order_path(2))
    response.should have_tag('tr+tr+tr th a[href=?]', order_path(3))
  end
      
end