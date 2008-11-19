require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/categories/new" do
  before(:each) do
    @category = Category.new

    # need to stub error object for my proper form ?

    assigns[:category] = @category
    assigns[:page_title] = "New Category"
    
    render 'admin/categories/new'
  end
  
  it "should display page title categories" do
    response.should have_tag('h1', "New Category")
  end
  
  it "should PUT to the category path" do
    response.should have_tag('form[action=?][method=?]', admin_categories_path, :post)
  end
  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li input[type=?][id=?]', "text", "category_name")
      with_tag('li input[type=?][id=?]', "text", "category_title")
      with_tag('li textarea[id=?]', "category_description")
    end
  end
  it "should display submit button" do
    response.should have_tag('form fieldset.submit') do
      with_tag('input[value=?]', "Create")
    end
  end

  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_categories_path, "back to categories list")
    end
  end

end