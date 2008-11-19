class LineItem < ActiveRecord::Base

  belongs_to :order
  
  validates_presence_of :name, :quantity, :price, :sku
  
  def self.new_from_cart_item(cart_item)
    self.create( { 
      :name=>cart_item.name , 
      :price => cart_item.price, 
      :sku =>cart_item.sku, 
      :quantity => cart_item.quantity 
    } )
  end
  
  def totalprice
    quantity * price
  end

  def discount_multiplier
    order ? order.discount_multiplier : 1.0
  end
  
  def before_discount_totalprice
    quantity * read_attribute(:price)
  end
  
  def price
    read_attribute(:price) * discount_multiplier
  end

end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: line_items
#
#  id         :integer(11)     not null, primary key
#  order_id   :integer(11)
#  name       :string(255)
#  price      :decimal(8, 2)   default(0.0)
#  quantity   :integer(11)
#  sku        :string(255)
#  created_at :datetime
#  updated_at :datetime

