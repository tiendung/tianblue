class CartItem < ActiveRecord::Base

  validates_presence_of :name, :price, :quantity, :sku
  
  belongs_to :cart
  
  def self.new_from_stock_unit(stock_unit, quantity=1)
    self.create( { :name=>stock_unit.name , :price => stock_unit.price, :sku => stock_unit.sku, :quantity => quantity } )
  end
  
  def increment_quantity(quantity)
    self.quantity += quantity
    self.save
  end
  
  def totalprice
    self.quantity * self.price
  end
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: cart_items
#
#  id         :integer(11)     not null, primary key
#  cart_id    :integer(11)
#  name       :string(255)
#  price      :decimal(8, 2)   default(0.0)
#  quantity   :integer(11)
#  sku        :string(255)
#  created_at :datetime
#  updated_at :datetime

