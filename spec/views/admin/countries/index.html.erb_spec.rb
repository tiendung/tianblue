require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/countries" do
  before(:each) do
    @countries = [
      mock_model(Country, :id => 1, :to_param => "1", :name => "Name1", :a2 => "AA", :a3=>"AAA", :numeric=>1),
      mock_model(Country, :id => 2, :to_param => "2", :name => "Name2", :a2 => "BB", :a3=>"BBB", :numeric=>2)
    ]

    assigns[:countries] = @countries
    assigns[:page_title] = "Countries"
    
    render 'admin/countries/index'
  end
  
  it "should display page title products" do
    response.should have_tag('h1', "Countries")
  end
  it "should show each country in a tabular format" do
    response.should have_tag('table tbody tr', 2)
  end
  it "should show names" do
    response.should have_tag('tbody th', /Name1/)
    response.should have_tag('tbody th', /Name2/)
  end
  it "should show email address" do
    response.should have_tag('tbody td', /AA/)
    response.should have_tag('tbody td', /BB/)
  end
  it "should show links to edit the order pages" do
    response.should have_tag('tbody th a[href=?]', edit_admin_country_path("1"))
    response.should have_tag('tbody tr+tr th a[href=?]', edit_admin_country_path("2"))
  end
  it "should link to new form" do
    response.should have_tag("a[href=?]", new_admin_country_path)
  end
      
end