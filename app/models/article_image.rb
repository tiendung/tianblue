class ArticleImage < ActiveRecord::Base
  belongs_to :article
  
  has_attachment  :content_type => :image,
                  :thumbnails => {
                    :main => "423x317!",
                    :mini => "205x153!",
                    :thumb => "45x45!"
                  },
                  :storage => :file_system,
                  :max_size => 1.megabyte
  
  validates_as_attachment
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: article_images
#
#  id           :integer(11)     not null, primary key
#  article_id   :integer(11)
#  parent_id    :integer(11)
#  content_type :string(255)
#  filename     :string(255)
#  height       :integer(11)
#  size         :integer(11)
#  thumbnail    :string(255)
#  width        :integer(11)
#  created_at   :datetime
#  updated_at   :datetime

