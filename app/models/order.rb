class Order < ActiveRecord::Base
  include Authentication

  has_many :items, :class_name => "LineItem", :dependent => :destroy
  belongs_to :user
  belongs_to :country
  belongs_to :promotion
  
  validates_presence_of :name, :address, :postcode
  validates_format_of :status, :with => /PENDING|PAID|SHIPPED|CANCELLED/
  
  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_format_of       :email,    :with => RE_EMAIL_OK, :message => MSG_EMAIL_BAD

  before_validation :set_default_status
  
  def self.new_from_cart(cart, params, promotion=nil)
    order = Order.new(params)
     if promotion
      order.promotion_id = promotion.id
      order.discount_multiplier = promotion.discount_multiplier
    end
    unless cart.empty?
      cart.items.each do |i|
        line_item = LineItem.new_from_cart_item(i)
        order.items << line_item
      end
      return order
    else
      nil
    end
  end
  
  def value
    value = 0.0
    self.items.each do |i|
      value += i.totalprice
    end
    return value
  end
  
  def pending?
    self.status == "PENDING" ? true : false
  end    
  
  def shipped?
    self.status == "SHIPPED" ? true : false
  end
  
  def ship_it
    self.status = "SHIPPED"
  end
  
  def self.pending
    Order.find_all_by_status("PENDING")
  end

  def self.paid
    Order.find_all_by_status("PAID", :order => "updated_at ASC")
  end

  def self.shipped
    Order.find_all_by_status("SHIPPED", :order => "updated_at DESC")
  end

  def self.cancelled
    Order.find_all_by_status("CANCELLED")
  end
  
  def self.sweep(time_ago = nil)
    time = case time_ago
      when /^(\d+)m$/ then Time.now.utc - $1.to_i.minute
      when /^(\d+)h$/ then Time.now.utc - $1.to_i.hour
      when /^(\d+)d$/ then Time.now.utc - $1.to_i.day
      else Time.now.utc - 1.day
    end
    self.destroy_all "updated_at < '#{time.to_s(:db)}' AND status = 'PENDING'"
  end
  
  
  private
  def set_default_status
    self.status = "PENDING" if self.status.nil?
  end
  
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: orders
#
#  id                    :integer(11)     not null, primary key
#  country_id            :integer(11)
#  promotion_id          :integer(11)
#  user_id               :integer(11)
#  address               :text
#  discount_multiplier   :decimal(8, 2)   default(1.0)
#  email                 :string(100)
#  name                  :string(255)
#  phone                 :string(20)
#  postcode              :string(255)
#  receive_update        :boolean(1)      default(TRUE)
#  status                :string(255)
#  transaction_reference :string(255)
#  created_at            :datetime
#  updated_at            :datetime

