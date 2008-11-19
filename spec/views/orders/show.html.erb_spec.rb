require File.dirname(__FILE__) + '/../../spec_helper'

describe "SHOW a PENDING order" do
  
  before(:each) do
    @country = mock_model(Country, :a2=>"AA")
    @order = mock_model(Order, :id => 1, :to_param => 1, :value => 10.00, :created_at => Time.now-1.days, :status => "PENDING", :name => "Name", :address => "Address", :postcode=>"12345", :country=>@country)
    @order.should_receive(:pending?).and_return(true)
    @item1 = mock_model(LineItem, :name => "Name1", :quantity => 2, :price => 2.00, :total_price => 4.00)
    @item2 = mock_model(LineItem, :name => "Name2", :quantity => 1, :price => 6.00, :total_price => 6.00)
    @current_user = mock_model(User, :email=>"test@domain.com")

    assigns[:current_user] = @current_user
    assigns[:order] = @order
    assigns[:items] = [@item1, @item2]
    assigns[:page_title] = "Order: #{ @order.created_at.strftime("%d %b %Y")}"
  
    render 'orders/show'
  end

  it "should display page title products" do
    response.should have_tag('h1', "Order: #{(Time.now-1.days).strftime("%e %b %Y")}")
  end
  it "should show order items in a tabular format" do
    response.should have_tag('table tbody tr', 2)
  end
  it "should show overall order price" do
    response.should have_tag('tfoot td', /\$10.00/)
  end

  it "should have a form that redirects to worldpay" do
    response.should have_tag('form[action=?]', "https://select-test.worldpay.com/wcc/purchase" || "https://select.worldpay.com/wcc/purchase") do
      with_tag("input[type=hidden][name=?][value=?]", "instId", "133248")
      with_tag("input[type=hidden][name=?][value=?]", "cartId", @order.id)
      with_tag("input[type=hidden][name=?][value=?]", "amount", @order.value)
      with_tag("input[type=hidden][name=?][value=?]", "currency", "SGD")
      with_tag("input[type=hidden][name=?][value=?]", "name", @order.name)
      with_tag("input[type=hidden][name=?][value=?]", "address", @order.address)
      with_tag("input[type=hidden][name=?][value=?]", "postcode", @order.postcode)
      with_tag("input[type=hidden][name=?][value=?]", "email", @current_user.email)
      with_tag("input[type=hidden][name=?][value=?]", "country", @order.country.a2)
      with_tag("input[type=submit]")
    end
  end
end
    
describe "SHOW any non-PENDING order" do

  before(:each) do
    @order = mock_model(Order, :id => 1, :to_param => 1, :value => 10.00, :created_at => Time.now-1.days, :status => "SHIPPED", :transaction_reference => "1234")
    @order.should_receive(:pending?).and_return(false)
    @item1 = mock_model(LineItem, :name => "Name1", :quantity => 2, :price => 2.00, :total_price => 4.00)
    @item2 = mock_model(LineItem, :name => "Name2", :quantity => 1, :price => 6.00, :total_price => 6.00)

    assigns[:order] = @order
    assigns[:items] = [@item1, @item2]
    assigns[:page_title] = "Your Order from #{ @order.created_at.strftime("%d %b %y")}"

    render 'orders/show'
  end
  
  it "should not show worldpay form" do
    response.should_not have_tag('form[action=?]', "https://select-test.worldpay.com/wcc/purchase" || "https://select.worldpay.com/wcc/purchase")
  end
  it "should show status" do
    response.should have_tag('h3', "SHIPPED")
  end
  it "should show transaction reference" do
    response.should have_tag("h4", /#{@order.transaction_reference}/)
  end
      
end