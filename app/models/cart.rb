class Cart < ActiveRecord::Base

  has_many :items, :class_name => "CartItem", :dependent => :delete_all

  def empty?
    self.items.nil? || self.items.empty?
  end
  
  def size
    if empty?
      0
    else
      self.items.count
    end
  end
  
  def find_item_by_sku(sku)
    items.find_by_sku(sku)
  end
  
  def add_stock_unit(stock_unit, quantity=1)
    quantity = quantity.to_i
    current = find_item_by_sku(stock_unit.sku)
    if current
      current.increment_quantity(quantity)
    else
      self.items << CartItem.new_from_stock_unit(stock_unit, quantity)
    end
  end
  
  def price
    cartprice = 0.0
    unless empty?
      items.each do |i|
        cartprice += i.totalprice
      end
    end
    cartprice
  end

  def number_of_items
    num = 0
    unless empty?
      items.each do |i|
        num += i.quantity
      end
    end
    num
  end

  # time_ago examples: 
  #   30m => 30 minutes
  #   1h  => 1 hour
  #   3d  => 3 days
  def self.sweep(time_ago = nil)
    time = case time_ago
      when /^(\d+)m$/ then Time.now.utc - $1.to_i.minute
      when /^(\d+)h$/ then Time.now.utc - $1.to_i.hour
      when /^(\d+)d$/ then Time.now.utc - $1.to_i.day
      else Time.now.utc - 1.day
    end
    self.destroy_all "updated_at < '#{time.to_s(:db)}'"
  end

end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: carts
#
#  id                  :integer(11)     not null, primary key
#  discount_multiplier :decimal(8, 2)   default(1.0)
#  created_at          :datetime
#  updated_at          :datetime

