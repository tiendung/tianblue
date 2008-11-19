class Product < ActiveRecord::Base

  validates_presence_of :name, :description, :price, :sku
  validates_numericality_of :price, :greater_than_or_equal_to => 0.01
  
  has_many :images, :class_name => "ProductImage", :dependent => :destroy
  has_many :stock_units, :dependent => :destroy, :include => :size, :order => "sizes.relative_order ASC"
  belongs_to :category
  
  before_save :lowercase_sku
  
  def html_description
    RedCloth.new(self.description).to_html
  end

  def mini_image_filename
    self.images.empty? ? false : self.images[0].public_filename(:mini)
  end
  
  def self.in_category(category)
    if category = Category.find_by_name(category, :include=>:products)
      products = category.products
    else
      false
    end
  end
  
  def to_param
    self.sku
  end
    
  private
  
  def lowercase_sku
    self.sku = self.sku.downcase
  end
  
end# == Schema Info
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

