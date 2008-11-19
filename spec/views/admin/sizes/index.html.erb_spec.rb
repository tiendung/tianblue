require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/sizes" do
  before(:each) do
    @sizes = [
      mock_model(Size, :id => 1, :to_param => "m", :code => "m", :name => "Size1"),
      mock_model(Size, :id => 2, :to_param => "l", :code => "l", :name => "Size2")
    ]

    assigns[:sizes] = @sizes
    assigns[:page_title] = "Sizes"
    
    render 'admin/sizes/index'
  end
  
  it "should display page title Sizes" do
    response.should have_tag('h1', "Sizes")
  end
  it "should show each size in a tabular format" do
    response.should have_tag('table tbody tr', 2)
  end
  it "should show links to the order pages" do
    response.should have_tag('tbody th', /Size1/)
    response.should have_tag('tbody tr+tr th', /Size2/)
  end
  it "should show links to edit the order pages" do
    response.should have_tag('tbody th a[href=?]', edit_admin_size_path("m"))
    response.should have_tag('tbody tr+tr th a[href=?]', edit_admin_size_path("l"))
  end
  it "should show the code" do
    response.should have_tag('tbody td', "m")
    response.should have_tag('tbody tr+tr td', "l")
  end
  it "should link to new form" do
    response.should have_tag("a[href=?]", new_admin_size_path)
  end
      
end