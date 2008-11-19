require File.dirname(__FILE__) + '/../spec_helper'

module StockUnitSpecHelper

  def valid_stock_unit_attributes
    {
      :stock => 20
    }
  end

  def valid_size
    mock_model(Size,
      :name => "SizeName",
      :description => "A description of the size",
      :code => "M"
    )
  end

  def valid_product
    mock_model(Product,
      :name => "Product Name",
      :description => "A description of the size",
      :price => 19.99,
      :sku => "ABCD"
    )
  end


end

describe StockUnit do
  include StockUnitSpecHelper

  before(:each) do
    @stock_unit = StockUnit.new
  end

  it "should be valid" do
    @stock_unit.attributes = valid_stock_unit_attributes
    @stock_unit.should be_valid
  end
  it "should belong to a product" do
    @stock_unit.attributes = valid_stock_unit_attributes
    @stock_unit.should belong_to(:product)
  end
  it "should belong to a size" do
    @stock_unit.attributes = valid_stock_unit_attributes
    @stock_unit.should belong_to(:size)
  end
  it "should have a stock level" do
    @stock_unit.should validate_presence_of(:stock)
    @stock_unit.attributes = valid_stock_unit_attributes.except(:stock)
    @stock_unit.should have_at_least(1).error_on(:stock)
  end
  it "should have a stock level equal or above 0" do
    @stock_unit.attributes = valid_stock_unit_attributes
    @stock_unit.in_stock?.should be_true
    @stock_unit.stock = -2
    @stock_unit.should have_at_least(1).error_on(:stock)
    @stock_unit.stock = 0
    @stock_unit.should be_valid
    @stock_unit.in_stock?.should be_false
  end
  
  describe "with other objects" do
    before(:each) do
      @stock_unit.attributes = valid_stock_unit_attributes
      @stock_unit.size = valid_size
      @stock_unit.product = valid_product
      @stock_unit.save      
    end
    it "should have a SKU: in the format PRODSKU-SIZE" do
      @stock_unit.sku.should == "ABCD-M"
    end
    it "should have a name: in the format Product (size)" do
      @stock_unit.name.should == "Product Name (SizeName)"
    end
    it "should have a name: in the format Product (size)" do
      @stock_unit.size_name.should == "SizeName"
    end
    it "should have a price" do
      @stock_unit.price.should be_close(19.99, 0.001)
    end
    it "should change stock level by sku" do
      lambda {
        @stock_unit.reduce_stock(2)
      }.should change(@stock_unit, :stock).from(20).to(18)
    end
    it "should not have the same size_id and product_id as another stock unit" do
      @stock_unit2 = StockUnit.new(valid_stock_unit_attributes)
      @stock_unit2.size = @stock_unit.size
      @stock_unit2.product = @stock_unit.product
      @stock_unit2.should have_at_least(1).error_on(:size_id)
    end
  end
  
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: stock_units
#
#  id         :integer(11)     not null, primary key
#  product_id :integer(11)
#  size_id    :integer(11)
#  sku        :string(255)
#  stock      :integer(11)     default(0)
#  created_at :datetime
#  updated_at :datetime

