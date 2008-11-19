require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/products/new" do
  before(:each) do
    Product.stub!(:new).and_return(@product = mock_model(Product, :name=>nil, :price=>nil, :stock=>nil, :sku=>nil, :description=>nil, :category_id=>nil))

    # need to stub error object for my proper form

    assigns[:product] = @product
    assigns[:page_title] = "New Product"
    
    render 'admin/products/new'
  end
  
  it "should display page title products" do
    response.should have_tag('h1', "New Product")
  end
  
  it "should PUT to the product path" do
    response.should have_tag('form[action=?][method=?]', admin_products_path, :post)
  end

  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li input[type=?][id=?]', "text", "product_name")
      with_tag('li input[type=?][id=?]', "text", "product_price")
      with_tag('li textarea[id=?]', "product_description")
      with_tag('li input[type=?][id=?]', "text", "product_stock")
      with_tag('li select[name=?] option', "product[category_id]")
      with_tag('li input[type=?][name=?]', "text", "product[sku]")
    end
  end
  
  it "should display submit button" do
    response.should have_tag('form fieldset.submit') do
      with_tag('input[value=?]', "Create")
    end
  end
      
  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_products_path, "back to products list")
    end
  end

end