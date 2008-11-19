require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/orders/show" do
  before(:each) do
    @order = mock_model(Order,
      :id => 1,
      :to_param => 1,
      :value => 10.00,
      :created_at => Time.now-1.days,
      :status => "PENDING",
      :name => "Name",
      :address => "Address",
      :postcode=>"12345",
      :country=>mock_model(Country, :name=>"Country"),
      :transaction_reference=> "ABCDEF",
      :user => mock_model(User, :to_param=>100, :email =>"email@dom.com")
    )

    @item1 = mock_model(LineItem, :name => "Name1", :quantity => 2, :price => 2.00, :total_price => 4.00)
    @item2 = mock_model(LineItem, :name => "Name2", :quantity => 1, :price => 6.00, :total_price => 6.00)

    assigns[:order] = @order
    assigns[:items] = [@item1, @item2]
    assigns[:page_title] = "Order: #{@order.id} - #{@order.created_at.strftime("%d %b, %y")}"
    
    render 'admin/orders/show'
  end
  
  it "should show date and id in page title" do
    response.should have_tag("h1", "Order: 1 - #{(Time.now-1.day).strftime("%d %b, %y")}")
  end
  it "should show total value of the order" do
    response.should have_tag("h2", /#{@order.value}/)
  end
  it "should display names of all the items" do
    response.should have_tag('table tbody tr th.text', /Name1/)
    response.should have_tag('table tbody tr+tr th.text', /Name2/)
  end
  it "should display quantity of all the items" do
    response.should have_tag('table tbody tr td.num', "2")
    response.should have_tag('table tbody tr+tr td.num', "1")
  end
  it "should show name, address and postcode" do
    content_for(:sub).should have_tag("p", /Name/)
    content_for(:sub).should have_tag("p", "Address")
    content_for(:sub).should have_tag("p", "12345")
    content_for(:sub).should have_tag("p strong", "Country")
  end
  it "should show link to user" do
    content_for(:sub).should have_tag("a[href=?]", admin_user_path(@order.user), @order.user.email)
  end
  it "should show form for setting status" do
    content_for(:sub).should have_tag('form[action=?]', admin_order_path(@order)) do
      with_tag("input[type=hidden][name=_method][value=put]")
      with_tag("select")
    end
  end
  it "should display transaction reference" do
    content_for(:sub).should have_tag("h4", /ABCDEF/)
  end
  it "should show delete button" do
      content_for(:sub).should have_tag('form[action=?]', admin_order_path(@order)) do
        with_tag("input[type=hidden][name=_method][value=delete]")
        with_tag("input[type=submit]")
      end
    end
  

end