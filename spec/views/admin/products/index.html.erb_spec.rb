require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/products with products" do
  before(:each) do
    @product1 = mock_model( Product, :name => "Product1", :price => 10.00, :sku => "SKU1", :to_param => "SKU1" )
    @product2 = mock_model( Product, :name => "Product2", :price => 22.00, :sku => "SKU2", :to_param => "SKU2" )
    @product3 = mock_model( Product, :name => "Product3", :price => 33.30, :sku => "SKU3", :to_param => "SKU3" )

    assigns[:products] = [@product1, @product2, @product3]
    
    render 'admin/products/index'
  end
  
  it "should display page title products" do
    response.should have_tag('h1', "Products")
  end
  
  it "should display all the products" do
    response.should have_tag('table tbody tr', 3)
  end
  
  it "should display names of all the products" do
    response.should have_tag('table tbody tr th.text', /Product1 \(SKU1\)/)
    response.should have_tag('table tbody tr+tr th.text', /Product2 \(SKU2\)/)
    response.should have_tag('table tbody tr+tr+tr th.text', /Product3 \(SKU3\)/)
  end

  it "should display prices of all the products" do
    response.should have_tag('table tbody tr td', "$10.00")
    response.should have_tag('table tbody tr+tr td', "$22.00")
    response.should have_tag('table tbody tr+tr+tr td', "$33.30")
  end
  
  it "should link to each edit page" do
    response.should have_tag('table tbody tr th a[href=?]', edit_admin_product_path(@product1), "edit")
    response.should have_tag('table tbody tr+tr th a[href=?]', edit_admin_product_path(@product2), "edit")
    response.should have_tag('table tbody tr+tr+tr th a[href=?]', edit_admin_product_path(@product3), "edit")
  end
  
  it "should link to new page" do
    response.should have_tag('a[href=?]', new_admin_product_path, "new")
  end
      
end