require File.dirname(__FILE__) + '/../../spec_helper'

describe "/products with in and out of stock products" do
  before(:each) do
    @product1 = mock_model( Product, :name => "Product1", :price => 10.00, :stock => 111, :sku => "SKU1", :to_param => "SKU1" )
    @product2 = mock_model( Product, :name => "Product2", :price => 22.00, :stock => 222, :sku => "SKU2", :to_param => "SKU2" )
    @product3 = mock_model( Product, :name => "Product3", :price => 33.30, :stock => 0, :sku => "SKU3", :to_param => "SKU3" )

    # @product1.stub!(:mini_image_filename).at_least(1).times.and_return("image1-1.jpg")
    # @product2.stub!(:mini_image_filename).at_least(1).times.and_return("image2-1.jpg")
    # @product3.stub!(:mini_image_filename).at_least(1).times.and_return(false)

    @image = mock_model(CategoryImage)
    @image.stub!(:public_filename).with(:main).and_return("image1.jpg")

    assigns[:image] = @image
    assigns[:products] = [@product1, @product2, @product3]
    assigns[:page_title] = "Page Title"
    
    template.expect_render(:partial => 'product', :locals => {:product => @product1}).and_return(%|<p id='product1_partial' />|)
    template.expect_render(:partial => 'product', :locals => {:product => @product2}).and_return(%|<p id='product2_partial' />|)
    template.expect_render(:partial => 'product', :locals => {:product => @product3}).and_return(%|<p id='product3_partial' />|)
    
    render 'products/index'
  end
  
  it "should display page title products" do
    response.should have_tag('h1', "Page Title")
  end
  
  it "should display main image" do
    response.should have_tag('div.image img')
  end
  
end