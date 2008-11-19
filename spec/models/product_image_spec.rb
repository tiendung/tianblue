require File.dirname(__FILE__) + '/../spec_helper'

describe ProductImage do

  TEST_PRODUCT_FILE = RAILS_ROOT + '/spec/fixtures/images/test_image.jpg'
  before(:each) do
    @image = ProductImage.new
    @image.filename = "image.jpg"
    @image.uploaded_data =
        ActionController::TestUploadedFile.new(TEST_PRODUCT_FILE,'image/jpg')
    @image.send :process_attachment
  end

  it "should be valid" do
    # TODO how to spec attachment_fu
    @image.should be_valid
  end
  
  it "should belong to an order" do
    @image.should belong_to(:product)
  end
  
end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: product_images
#
#  id           :integer(11)     not null, primary key
#  parent_id    :integer(11)
#  product_id   :integer(11)
#  content_type :string(255)
#  filename     :string(255)
#  height       :integer(11)
#  size         :integer(11)
#  thumbnail    :string(255)
#  width        :integer(11)
#  created_at   :datetime
#  updated_at   :datetime

