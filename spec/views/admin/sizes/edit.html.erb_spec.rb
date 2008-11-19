require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/sizes/xx/edit" do
  before(:each) do
    @size = mock_model(Size,
      :id => 1,
      :to_param => "m",
      :name=>"SizeName",
      :code=>"m",
      :description=>"Description",
      :relative_order=>"23"
    )

    assigns[:size] = @size
    assigns[:page_title] = "Edit " + @size.name
    
    render 'admin/sizes/edit'
  end
  
  it "should display page title sizes" do
    response.should have_tag('h1', "Edit #{@size.name}")
  end
  
  it "should PUT to the size path" do
    response.should have_tag('form[action=?][method=?]', admin_size_path(@size), :post) do
      with_tag("input[type=hidden][name=_method][value=?]", "put")
    end
  end
  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li input[type=?][id=?]', "text", "size_name")
      with_tag('li input[type=?][id=?]', "text", "size_code")
      with_tag('li input[type=?][id=?]', "text", "size_relative_order")
      with_tag('li textarea[id=?]', "size_description")
    end
  end
  it "should display submit button" do
    response.should have_tag('form fieldset.submit') do
      with_tag('input[value=?]', "Update")
    end
  end

  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_sizes_path, "back to sizes list")
    end
  end

end