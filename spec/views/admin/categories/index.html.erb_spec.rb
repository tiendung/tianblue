require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/categories" do
  before(:each) do
    @categories = [
      mock_model(Order, :id => 1, :to_param => 1, :name => "Category1"),
      mock_model(Order, :id => 2, :to_param => 2, :name => "Category2")
    ]

    assigns[:categories] = @categories
    assigns[:page_title] = "Categories"
    
    render 'admin/categories/index'
  end
  
  it "should display page title products" do
    response.should have_tag('h1', "Categories")
  end
  it "should show each category in a tabular format" do
    response.should have_tag('table tbody tr', 2)
  end
  it "should show links to the order pages" do
    # response.should have_tag('tbody th a[href=?]', admin_category_path(1), "Category1")
    # response.should have_tag('tbody tr+tr th a[href=?]', admin_category_path(2), "Category2")
    response.should have_tag('tbody th', /Category1/)
    response.should have_tag('tbody tr+tr th', /Category2/)
  end
  it "should show links to edit the order pages" do
    response.should have_tag('tbody th a[href=?]', edit_admin_category_path(1))
    response.should have_tag('tbody tr+tr th a[href=?]', edit_admin_category_path(2))
  end
  
  it "should link to new form" do
    response.should have_tag("a[href=?]", new_admin_category_path)
  end
      
end