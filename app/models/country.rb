class Country < ActiveRecord::Base

  has_many :orders
  
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: countries
#
#  id         :integer(11)     not null, primary key
#  a2         :string(255)
#  a3         :string(255)
#  name       :string(255)
#  numeric    :integer(11)
#  created_at :datetime
#  updated_at :datetime

