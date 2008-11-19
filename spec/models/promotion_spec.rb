require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Promotion do
  before(:each) do
    @valid_attributes = {
      :promotion_code => "value for promotion_code",
      :promotion_name => "value for promotion_name",
      :discount_percentage => "1",
      :valid_from => Time.now,
      :valid_until => Time.now,
      :activate_now => false
    }
  end

  it "should create a new instance given valid attributes" do
    Promotion.create!(@valid_attributes)
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

