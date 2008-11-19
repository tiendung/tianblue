require File.dirname(__FILE__) + '/../../spec_helper'

describe "/orders/new" do
  before(:each) do
    Order.stub!(:new).and_return(@order = mock_model(Order, :name=>nil, :address =>nil, :postcode=>nil, :country_id=>nil))

    assigns[:cart] = mock_model(Cart, :price=>54.32, :number_of_items => 3 )
    assigns[:order] = @order
    assigns[:page_title] = "Checkout"
    
    render 'orders/new'
  end
  
  it "should display page title products" do
    response.should have_tag('h1', "Checkout")
  end
  
  it "should display a cart summary" do
    response.should have_tag('h2', "Total Price: $54.32 (3 items)" )
  end
  
  it "should POST to the product path" do
    response.should have_tag('form[action=?][method=?]', orders_path, :post)
  end

  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li input[type=?][id=?]', "text", "order_name")
      with_tag('li textarea[id=?]', "order_address")
      with_tag('li input[type=?][id=?]', "text", "order_postcode")
      with_tag('li select[name=?]', "order[country_id]")
    end
  end
  
  it "should display submit button" do
    response.should have_tag('form fieldset.submit') do
      with_tag('input[value=?]', "Checkout")
    end
  end
      
end