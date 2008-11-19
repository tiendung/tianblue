require File.dirname(__FILE__) + '/../spec_helper'

describe Country do
  before(:each) do
    @country = Country.new
  end

  it "should be valid" do
    @country.should be_valid
  end
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

