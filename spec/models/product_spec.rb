require File.dirname(__FILE__) + '/../spec_helper'

module ProductSpecHelper

  def valid_product_attributes
    {
      :name => "Name",
      :description => "A description",
      :price => 10.00,
      :sku => "333SKU"
    }
  end

end

describe Product do
  include ProductSpecHelper
  
  before(:each) do
    @product = Product.new
  end

  it "should be valid" do
    @product.attributes = valid_product_attributes
    @product.should be_valid
  end

  it "should have many images" do
    @product.should have_many(:images)
  end

  it "should have many stock units" do
    @product.should have_many(:stock_units)
  end

  it "should have belong to a category" do
    @product.should belong_to(:category)
  end
  
  it "should have a name" do
    @product.attributes = valid_product_attributes.except(:name)
    @product.should have(1).error_on(:name)
  end
  
  it "should have a description" do
    @product.attributes = valid_product_attributes.except(:description)
    @product.should have(1).error_on(:description)
  end
  
  it "should have an HTML description based on textile version of description" do
    @product.attributes = valid_product_attributes
    @product.html_description.should eql(RedCloth.new(@product.description).to_html)
    @product.html_description.should eql("<p>A description</p>")
  end
  
  it "should have a price" do
    @product.should validate_presence_of(:price)
    @product.attributes = valid_product_attributes.except(:price)
    @product.should have_at_least(1).error_on(:price)
  end
    
  it "should have a SKU" do
    @product.should validate_presence_of(:sku)
    @product.attributes = valid_product_attributes.except(:sku)
    @product.should have_at_least(1).error_on(:sku)
  end
  it "should store sku in lowercase" do
    @product.attributes = valid_product_attributes
    @product.save
    @product.sku.should == "333sku"
  end
  
  it "should return the SKU for to_param for routing" do
    @product.attributes = valid_product_attributes
    @product.to_param.should == "333SKU"
  end
    
  it "should have a price greater than or equal to 1 cent" do
    @product.attributes = valid_product_attributes
    @product.price = -2
    @product.should have_at_least(1).error_on(:price)
    @product.price = 0
    @product.should have_at_least(1).error_on(:price)
    @product.price = 0.001
    @product.should have_at_least(1).error_on(:price)
    @product.price = 0.01
    @product.should be_valid
  end
  
  it "should get all products in a valid category" do
    @product.attributes = valid_product_attributes
    @category = Category.create({:id=>1, :name=>"men", :title=>"Men's Polos"})

    @product2 = Product.create(valid_product_attributes)
    @product2.category = @category
    @product2.save
    
    @products = Product.in_category("men")
    @products.should == [@product2]
  end

  it "should return false on an invalid category" do
    @product.attributes = valid_product_attributes
    @category = Category.create({:id=>1, :name=>"men"})

    @product2 = Product.create(valid_product_attributes)
    @product2.category = @category
    @product2.save
    
    @products = Product.in_category("not_valid")
    @products.should == false
  end

  it "should return the first mini image filename" do
    @product.attributes = valid_product_attributes
    @product.images.should be_empty
    @product.mini_image_filename.should be_false
    image = ProductImage.new
    image.stub!(:public_filename).with(:mini).and_return("mini.jpg")
    @product.images << image
    @product.mini_image_filename.should == "mini.jpg"
    image2 = ProductImage.new
    image2.stub!(:public_filename).with(:mini).and_return("mini2.jpg")
    @product.images << image2
    @product.mini_image_filename.should == "mini.jpg"
  end

end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: products
#
#  id          :integer(11)     not null, primary key
#  category_id :integer(11)
#  description :text
#  name        :string(255)
#  price       :decimal(8, 2)   default(0.0)
#  sku         :string(255)
#  created_at  :datetime
#  updated_at  :datetime

