require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/countries/new" do
  before(:each) do
    @country = mock_model(Country, :name=>nil, :a2=>nil, :a3=>nil, :numeric=>nil )

    # need to stub error object for my proper form ?

    assigns[:country] = @country
    assigns[:page_title] = "New Country"
    
    render 'admin/countries/new'
  end
  
  it "should display page title countries" do
    response.should have_tag('h1', "New Country")
  end
  
  it "should PUT to the country path" do
    response.should have_tag('form[action=?][method=?]', admin_countries_path, :post)
  end
  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li input[type=?][id=?]', "text", "country_name")
      with_tag('li input[type=?][id=?]', "text", "country_a2")
      with_tag('li input[type=?][id=?]', "text", "country_a3")
      with_tag('li input[type=?][id=?]', "text", "country_numeric")
    end
  end
  it "should display submit button" do
    response.should have_tag('form fieldset.submit') do
      with_tag('input[value=?]', "Create")
    end
  end

  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_countries_path, "back to countries list")
    end
  end

end