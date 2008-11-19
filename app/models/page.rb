class Page < ActiveRecord::Base

  validates_presence_of :name, :body

  has_one :image, :class_name => "PageImage", :dependent => :destroy

  before_save :generate_permalink
  
  def html_body
    RedCloth.new(self.body).to_html
  end
  
  def to_param
    self.permalink
  end
  
  private
  
  def generate_permalink
    s = self.name.dup
    s.sub!(/http:\/\//, '')
    s.gsub!(/\W+/, ' ') # all non-word chars to spaces
    s.strip!
    s.downcase!
    s.gsub!(/\ +/, "-") # spaces to dashes
    self.permalink = s
  end

end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: pages
#
#  id         :integer(11)     not null, primary key
#  body       :text
#  name       :string(255)
#  permalink  :string(255)
#  created_at :datetime
#  updated_at :datetime

