require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/stock_units/xx/edit" do
  before(:each) do
    @product = Product.create(:name => "Product")
    @size = Size.create(:name => "Size", :code =>"s")
    @stock_unit = StockUnit.create(
      :stock => 10,
      :product => @product,
      :size => @size
    )
    
    assigns[:stock_unit] = @stock_unit
    assigns[:page_title] = "Edit " + @stock_unit.name + " &#187; StockUnits"
    
    render 'admin/stock_units/edit'
  end
  
  it "should display stock_unit name stock_units" do
    response.should have_tag('h1', "Edit Product (Size) &#187; StockUnits")
  end
  
  it "should PUT to the stock_unit path" do
    response.should have_tag('form[action=?]', admin_product_stock_unit_path(@product, @stock_unit)) do
      with_tag('input[name=?][type=?][value=?]', "_method", "hidden", "put")
    end
  end
  
  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li input[type=?][id=?]', "text", "stock_unit_stock")
      with_tag('li select[name=?]', "stock_unit[size_id]")
    end
  end
  
  it "should display submit button" do
    response.should have_tag('form fieldset.submit') do
      with_tag('input[value=?]', "Update")
    end
  end
  
  it "should have a link back" do
    response.should have_tag('a[href=?]', edit_admin_product_path(@product) )
  end
      
end