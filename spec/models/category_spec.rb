require File.dirname(__FILE__) + '/../spec_helper'

module CategorySpecHelper

  def valid_category_attributes
    {
      :name => "category",
      :title => "title"
    }
  end

end

describe Category do

  include CategorySpecHelper

  before(:each) do
    @category = Category.new
  end

  it "should be valid" do
    @category.attributes = valid_category_attributes
    @category.should be_valid
  end
  
  it "should have many products" do
    @category.should have_many(:products)
  end

  it "should have one image" do
    @category.should have_one(:image)
  end
  
  it "should have a name" do
    @category.attributes = valid_category_attributes.except(:name)
    @category.should have_at_least(1).error_on(:name)
  end
  it "should have a title" do
    @category.attributes = valid_category_attributes.except(:title)
    @category.should have_at_least(1).error_on(:title)
  end
  
  it "shouldn't allow duplicate category names" do
    @category.attributes = valid_category_attributes
    @category.save
    @category2 = Category.new(valid_category_attributes)
    @category2.should have_at_least(1).error_on(:name)
  end
  
  it "should only allow single word names with no punctuation (apart from dashes) or spaces" do
    @category.attributes = valid_category_attributes
    @category.name = "Two Words"
    @category.should have_at_least(1).error_on(:name)
    @category.name = "Words1"
    @category.should have_at_least(1).error_on(:name)
    @category.name = "Wor!ds"
    @category.should have_at_least(1).error_on(:name)
    @category.name = "Wor-ds"
    @category.should be_valid
  end

  it "should automatically convert names to lowercase and strip any space either side" do
    @category.attributes = valid_category_attributes
    @category.name = "ONE"
    @category.save
    @category.name.should == "one"
    
    @category.name = "  Two "
    @category.save
    @category.name.should eql("two")
  end
  
  it "should give two featured categories" do
    @category.attributes = valid_category_attributes.merge(:featured=>true)
    @category.save
    @category2 = Category.create(valid_category_attributes.merge(:name=>"two",:featured=>true))
    @category3 = Category.create(valid_category_attributes.merge(:name=>"three",:featured=>false))
    Category.featured.should == [@category,@category2]
  end
  it "should return the name for to_param for routing" do
    @category.attributes = valid_category_attributes
    @category.save
    @category.to_param.should == "category"
    @category.to_param.should == @category.name
  end
  it "should return the first mini image filename" do
    @category.attributes = valid_category_attributes
    @category.image.should be_nil
    @category.mini_image_filename.should be_false
    image = CategoryImage.new
    image.stub!(:public_filename).with(:mini).and_return("mini.jpg")
    @category.image = image
    @category.mini_image_filename.should == "mini.jpg"
  end
  
  
  
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: categories
#
#  id          :integer(11)     not null, primary key
#  description :text
#  featured    :boolean(1)
#  name        :string(255)
#  title       :string(255)
#  created_at  :datetime
#  updated_at  :datetime

