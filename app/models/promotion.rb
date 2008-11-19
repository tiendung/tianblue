class Promotion < ActiveRecord::Base
  
  validates_presence_of :promotion_code, :greeting, :discount_percentage
  validates_uniqueness_of :promotion_code
  validates_numericality_of :discount_percentage, :less_than => 100, :greater_than => 0
  
  def apply(x)
    is_valid ? x * discount_multiplier : x
  end
  
  def discount_multiplier
    is_valid ? (100.0 - discount_percentage.to_f) / 100.0 : 1.0
  end
  
  def is_valid
    today = Date.today
    activate_now and valid_from <= today and today <= valid_until
  end
  
  def self.all_for_select
    self.find( :all ).map { |p| [ "#{p.promotion_code} - #{p.promotion_name}", p.id ] }    
  end
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: promotions
#
#  id                  :integer(11)     not null, primary key
#  activate_now        :boolean(1)
#  discount_percentage :decimal(8, 2)   default(0.0)
#  greeting            :string(999)
#  promotion_code      :string(50)
#  promotion_name      :string(250)
#  valid_from          :date
#  valid_until         :date
#  created_at          :datetime
#  updated_at          :datetime

