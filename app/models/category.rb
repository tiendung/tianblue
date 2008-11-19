class Category < ActiveRecord::Base

  validates_presence_of :name, :title
  validates_uniqueness_of :name
  validates_format_of :name, :with => /^[\s]*[A-Za-z\-]+[\s]*$/
  
  has_many :products, :dependent => :nullify
  
  before_save :lowercase_name

  has_one :image, :class_name => "CategoryImage", :dependent => :destroy

  named_scope :featured, :conditions => {:featured => true }
  
  def mini_image_filename
    self.image.nil? ? false : self.image.public_filename(:mini)
  end

  def to_param
    self.name
  end

  private
  
  def lowercase_name
    self.name = self.name.strip.downcase
  end
  
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: categories
#
#  id          :integer(11)     not null, primary key
#  description :text
#  featured    :boolean(1)
#  name        :string(255)
#  title       :string(255)
#  created_at  :datetime
#  updated_at  :datetime

