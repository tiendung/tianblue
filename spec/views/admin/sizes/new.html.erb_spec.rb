require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/sizes/new" do
  before(:each) do
    @size = mock_model(Size, :name=>nil, :code=>nil, :description=>nil, :relative_order=>nil)

    # need to stub error object for my proper form ?

    assigns[:size] = @size
    assigns[:page_title] = "New Size"
    
    render 'admin/sizes/new'
  end
  
  it "should display page title sizes" do
    response.should have_tag('h1', "New Size")
  end
  
  it "should PUT to the size path" do
    response.should have_tag('form[action=?][method=?]', admin_sizes_path, :post)
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
      with_tag('input[value=?]', "Create")
    end
  end

  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_sizes_path, "back to sizes list")
    end
  end

end