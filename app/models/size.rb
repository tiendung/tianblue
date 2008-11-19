class Size < ActiveRecord::Base

  validates_presence_of :name, :description, :code
  validates_length_of :code, :within => 1..3
  validates_uniqueness_of :name
  validates_uniqueness_of :code
  validates_format_of :code, :with => /\A[A-Za-z0-9]{1,3}\Z/
  
  before_save :lowercase_code

  def to_param
    self.code
  end

  private
  
  def lowercase_code
    self.code = self.code.downcase    
  end

end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: sizes
#
#  id             :integer(11)     not null, primary key
#  code           :string(255)
#  description    :text
#  name           :string(255)
#  relative_order :integer(11)
#  created_at     :datetime
#  updated_at     :datetime

