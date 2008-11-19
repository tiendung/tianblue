class StockUnit < ActiveRecord::Base

  belongs_to :product
  belongs_to :size

  validates_presence_of :stock
  validates_numericality_of :stock, :greater_than_or_equal_to => 0
  validates_uniqueness_of :size_id, :scope => :product_id

  before_save :generate_sku

  def name
    "#{self.product.name} (#{self.size.name})"
  end
  def size_name
    self.size.name
  end

  def price
    self.product.price
  end
  def in_stock?
    self.stock > 0 ? true : false
  end
  def reduce_stock(number)
    self.stock = self.stock - number
  end

  private
  
  def generate_sku
    self.sku = "#{self.product.sku}-#{self.size.code}"
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

