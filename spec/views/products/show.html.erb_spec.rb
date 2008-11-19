require File.dirname(__FILE__) + '/../../spec_helper'

describe "SHOW products - /products/xx -" do

  before(:each) do
    @image1 = mock_model(ProductImage)
    @image1.stub!(:public_filename).with(:main).and_return("image1.jpg")
    @image1.stub!(:public_filename).with(:thumb).and_return("image1_thumb.jpg")
    @image2 = mock_model(ProductImage)
    @image2.stub!(:public_filename).with(:main).and_return("image2.jpg")
    @image2.stub!(:public_filename).with(:thumb).and_return("image2_thumb.jpg")
    @stock_unit1 = mock_model(StockUnit,
      :id => 1,
      :to_param => 1,
      :name => "Brown Trousers (medium)",
      :size_name => "medium",
      :sku => "sku-m"
    )
    @stock_unit2 = mock_model(StockUnit,
      :id => 2,
      :to_param => 2,
      :name => "Brown Trousers (large)",
      :size_name => "large",
      :sku => "sku-l"
    )
    @category = mock_model( Category, :id => 10, :to_param => 10, :name => "Category1" )
    @product = mock_model( Product,
      :name => "Brown Trousers",
      :sku => "sku",
      :price => 23.99,
      :html_description => "<p>Lovely Velour, Brown Trousers</p>",
      :to_param => "sku",
      :images => [@image1, @image2],
      :stock_units => [@stock_unit1, @stock_unit2],
      :category => @category
    )

    assigns[:product] = @product
    assigns[:stock_units] = @product.stock_units

    render 'products/show'
  end

  describe "with in stock product" do
    
    it "should display name" do
      response.should have_tag('h1', "Brown Trousers")
    end
  
    it "should display price" do
      response.should have_tag('p', "$23.99")
    end
  
    it "should display description" do
      response.should have_tag('p', "Lovely Velour, Brown Trousers")
    end
    it "should display category" do
      response.should have_tag('p.info a[href=?]', category_url(@category.name), @category.name)
    end

    it "should display main image" do
      response.should have_tag('img.main')
    end

    it "should display thumbnail gallery" do
      response.should have_tag('ul.thumbs li a[href=?] img', "image1.jpg")
      response.should have_tag('ul.thumbs li a[href=?] img', "image2.jpg")
    end 
    it "should display an add to cart button for each stock unit" do    
      response.should have_tag('form[action=?][method=?]', cart_items_path, :post) do
        with_tag('td input[type=?][name=?]', "text", "cart_item[quantity]")
        with_tag('td select[name=?] option', "cart_item[sku]")
        with_tag('input[value=?]', "Add to Cart")
      end
    end
  
  end

  # describe "with out of stock product" do  
  #   it "should not display add to cart button" do
  #     response.should_not have_tag('form[action=?][method=?]', add_to_cart_product_path(@product), :post)
  #   end
  # end
  
end