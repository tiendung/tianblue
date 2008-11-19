require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/stock_units/new" do
  before(:each) do
    @product = mock_model(Product, :to_param => "1")
    StockUnit.stub!(:new).and_return(@stock_unit = mock_model(StockUnit, :stock=>nil, :size_id=>nil ))

    # need to stub error object for my proper form

    assigns[:stock_unit] = @stock_unit
    assigns[:page_title] = "New StockUnit"
    assigns[:product] = @product
    
    render 'admin/stock_units/new'
  end
  
  it "should display stock_unit name stock_units" do
    response.should have_tag('h1', "New StockUnit")
  end
  
  it "should PUT to the stock_unit path" do
    response.should have_tag('form[action=?][method=?]', admin_product_stock_units_path(@product), :post)
  end

  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li input[type=?][id=?]', "text", "stock_unit_stock")
      with_tag('li select[name=?]', "stock_unit[size_id]")
    end
  end
  
  it "should display submit button" do
    response.should have_tag('form fieldset.submit') do
      with_tag('input[value=?]', "Create")
    end
  end
      
  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_product_stock_units_path(@product), "back to stock_units list")
    end
  end

end