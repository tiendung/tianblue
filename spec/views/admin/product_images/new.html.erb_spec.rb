require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/products/x/images/new" do
  before(:each) do
    Product.stub!(:find).and_return(@product = mock_model(Product, :name=>"ProductName", :to_param => 1))

    # need to stub error object for my proper form
    # @errors = mock_model(Object)
    # @errors.stub!(:on).with(any_args).and_return(nil)
    # @product.stub!(:errors).and_return(@errors)

    assigns[:product] = @product
    assigns[:page_title] = "New Image for ProductName"
    
    render 'admin/product_images/new'
  end
  
  it "should display page title products" do
    response.should have_tag('h1', "New Image for ProductName")
  end
  
  it "should PUT to the product path" do
    response.should have_tag('form[action=?][method=?]', admin_product_images_path(@product), :post)
  end

  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li label', "Select Image")
      with_tag('li input[type=?][id=?]', "file", "image_uploaded_data")
    end
  end
  
  it "should display submit button" do
    response.should have_tag('form fieldset.buttons') do
      with_tag('input[value=?]', "Create")
    end
  end
      
  it "should have a link back" do
    response.should have_tag('form fieldset.buttons') do
      with_tag('a[href=?]', edit_admin_product_path(@product), "back to edit product")
      with_tag('a[href=?]', admin_products_path, "back to products list")

    end
  end

end