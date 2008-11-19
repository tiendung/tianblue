require File.dirname(__FILE__) + '/../spec_helper'

describe PageImage do
  TEST_FILE_PAGE_IMAGE = RAILS_ROOT + '/spec/fixtures/images/test_image.jpg'
  before(:each) do
    @image = PageImage.new
    @image.filename = "image.jpg"
    @image.uploaded_data =
        ActionController::TestUploadedFile.new(TEST_FILE_PAGE_IMAGE,'image/jpg')
    @image.send :process_attachment
  end

  it "should be valid" do
    @image.should be_valid
  end
  
  it "should belong to an page" do
    @image.should belong_to(:page)
  end
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: page_images
#
#  id           :integer(11)     not null, primary key
#  page_id      :integer(11)
#  parent_id    :integer(11)
#  content_type :string(255)
#  filename     :string(255)
#  height       :integer(11)
#  size         :integer(11)
#  thumbnail    :string(255)
#  width        :integer(11)
#  created_at   :datetime
#  updated_at   :datetime

