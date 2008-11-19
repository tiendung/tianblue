require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/countries/xx/edit" do
  before(:each) do
    @country = mock_model(Country,
      :id => 1,
      :to_param => 1,
      :name=>"CountryName",
      :a2=>"AA",
      :a3=>"BBB",
      :numeric=>1
    )

    assigns[:country] = @country
    assigns[:page_title] = "Edit " + @country.name
    
    render 'admin/countries/edit'
  end
  
  it "should display page title countries" do
    response.should have_tag('h1', "Edit #{@country.name}")
  end
  it "should PUT to the country path" do
    response.should have_tag('form[action=?][method=?]', admin_country_path(@country), :post) do
      with_tag("input[type=hidden][name=_method][value=?]", "put")
    end
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
      with_tag('input[value=?]', "Update")
    end
  end
  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_countries_path, "back to countries list")
    end
  end

end