require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/products with products" do
  before(:each) do
    @product = mock_model( Product, 
      :name => "Brown Trousers",
      :description => "Brown Trousers are nice",
      :price => 23.99,
      :sku => "SKU",
      :category_id => 1,
      :to_param => "SKU",
      :images => [
        @image1 = mock_model( ProductImage, :to_param => 1),
        @image2 = mock_model( ProductImage, :to_param => 2)
      ],
      :stock_units => [
        @stock_unit1 = mock_model( StockUnit, :to_param => 1, :sku => "ABCD-M", :name=>"stock name 1", :stock => 10),
        @stock_unit2 = mock_model( StockUnit, :to_param => 2, :sku => "ABCD-M", :name=>"stock name 2", :stock => 20)
      ]
    )
    @image1.stub!(:public_filename).with(:thumb).and_return('image1.jpg')
    @image2.stub!(:public_filename).with(:thumb).and_return('image2.jpg')
    
    # need to stub erros object for my proper form
    @errors = mock_model(Object)
    @errors.stub!(:on).with(any_args).and_return(nil)
    @product.stub!(:errors).and_return(@errors)

    assigns[:product] = @product
    assigns[:page_title] = "Edit " + @product.name + " &#187; Products"
    assigns[:images] = @product.images
    assigns[:stock_units] = @product.stock_units
    
    render 'admin/products/edit'
  end
  
  it "should display page title products" do
    response.should have_tag('h1', "Edit Brown Trousers &#187; Products")
  end
  
  it "should PUT to the product path" do
    response.should have_tag('form[action=?]', admin_product_path(@product)) do
      with_tag('input[name=?][type=?][value=?]', "_method", "hidden", "put")
    end
  end
  
  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li input[type=?][id=?][value=?]', "text", "product_name", "Brown Trousers")
      with_tag('li input[type=?][id=?][value=?]', "text", "product_price", "23.99")
      with_tag('li textarea[id=?]', "product_description")
      with_tag('li select[name=?] option', "product[category_id]")
      with_tag('li input[type=?][name=?][value=?]', "text", "product[sku]", "SKU")
    end
  end

  it "should display submit button" do
    response.should have_tag('form fieldset.submit') do
      with_tag('input[value=?]', "Update")
    end
  end
  
  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_products_path, "back to products list")
    end
  end

  it "should show images" do
    content_for(:sub).should have_tag('ul.images') do
      with_tag('li img[src=?]', "image1.jpg")
      with_tag('li img[src=?]', "image2.jpg")
    end
  end
  
  it "should show buttons to destroy images" do
    content_for(:sub).should have_tag('ul.images li') do
      with_tag('form[action=?] input[value=?]', admin_product_image_path(@product, @image1), "Delete")
      with_tag('form[action=?] input[value=?]', admin_product_image_path(@product, @image2), "Delete")
      with_tag('input[name=?][type=?][value=?]', "_method", "hidden", "delete", 2)
    end    
  end

  it "should have a link to new images" do
    content_for(:sub).should have_tag('a[href=?]', new_admin_product_image_path(@product), "Add a new image")
  end

  it "should have a link to new stock units" do
    content_for(:sub).should have_tag('a[href=?]', new_admin_product_stock_unit_path(@product), "Add a new stock unit")
  end

  it "should display all the products" do
    content_for(:sub).should have_tag('table tbody tr', 2)
  end
  
  it "should display names of all the products" do
    content_for(:sub).should have_tag('table tbody tr th.text', /stock name 1/)
    content_for(:sub).should have_tag('table tbody tr+tr th.text', /stock name 2/)
  end

  it "should display links to of all the stock items" do
    content_for(:sub).should have_tag('table tbody tr a[href=?]', edit_admin_product_stock_unit_path(@product, @stock_unit1))
    content_for(:sub).should have_tag('table tbody tr+tr a[href=?]', edit_admin_product_stock_unit_path(@product, @stock_unit2))
  end

  it "should display stock of all the stock units" do
    content_for(:sub).should have_tag('table tbody tr td', "10")
    content_for(:sub).should have_tag('table tbody tr+tr td', "20")
  end

      
end