require File.dirname(__FILE__) + '/../../spec_helper'

describe "product partial" do
  before(:each) do
    @product1 = mock_model( Product, :name => "Product1", :price => 10.00, :stock => 111, :sku => "SKU1", :to_param => "SKU1" )
  end
  describe "with image" do
    before(:each) do
      @product1.stub!(:mini_image_filename).at_least(1).times.and_return("image1-1.jpg")
      render :partial => 'products/product', :locals => {:product => @product1}
    end

    it "should link to product page" do
      response.should have_tag('li h2 a[href=?]', product_path(@product1), /Product1/)
    end
    it "should link to the product with mini image" do
      response.should have_tag('li a[href=?] img', product_path(@product1))
    end
  end

  describe "with no mini-image" do
    before(:each) do
      @product1.stub!(:mini_image_filename).at_least(1).times.and_return(false)
      render :partial => 'products/product', :locals => {:product => @product1}
    end
  
    it "should not display mini image if there is none" do
      response.should_not have_tag('li a[href=?] img', product_path(@product1))
    end

  end

end