class Article < ActiveRecord::Base

  has_many :images, :class_name => "ArticleImage", :dependent => :destroy

  validates_presence_of :title, :body, :summary, :message => "can't be blank"
  
  before_save :set_date, :generate_permalink
  
  named_scope :current, :conditions=>["posted_at < ?",Time.now], :order => "posted_at DESC"
  
  def html_body
    RedCloth.new(self.body).to_html
  end

  def html_summary
    RedCloth.new(self.summary).to_html
  end
  
  def self.top
    self.current.first
  end
  
  def mini_image_filename
    self.images.empty? ? false : self.images[0].public_filename(:mini)
  end
  
  def to_param
    self.permalink
  end
  
  private
  def set_date
    self.posted_at = Time.now unless self.posted_at
  end
  def generate_permalink
    s = self.title.dup
    s.sub!(/http:\/\//, '')
    s.gsub!(/\W+/, ' ') # all non-word chars to spaces
    s.strip!
    s.downcase!
    s.gsub!(/\ +/, "-") # spaces to dashes
    self.permalink = posted_at.strftime("%d-%m-%y-")+s
  end
  
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: articles
#
#  id         :integer(11)     not null, primary key
#  body       :text
#  permalink  :string(255)
#  summary    :text
#  title      :string(255)
#  created_at :datetime
#  posted_at  :datetime
#  updated_at :datetime

