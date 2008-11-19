require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/categories/x/image/new" do
  before(:each) do
    Category.stub!(:find).and_return(@category = mock_model(Category, :name=>"CategoryName", :to_param => 1))

    # need to stub error object for my proper form
    # @errors = mock_model(Object)
    # @errors.stub!(:on).with(any_args).and_return(nil)
    # @category.stub!(:errors).and_return(@errors)

    assigns[:category] = @category
    assigns[:page_title] = "New Image for CategoryName"
    
    render 'admin/category_images/new'
  end
  
  it "should display page title categorys" do
    response.should have_tag('h1', "New Image for CategoryName")
  end
  
  it "should PUT to the category path" do
    response.should have_tag('form[action=?][method=?]', admin_category_image_path(@category), :post)
  end

  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li label', "Select Image")
      with_tag('li input[type=?][id=?]', "file", "image_uploaded_data")
    end
  end
  
  it "should display submit button" do
    response.should have_tag('form fieldset.buttons') do
      with_tag('input[value=?]', "Create")
    end
  end
      
  it "should have a link back" do
    response.should have_tag('form fieldset.buttons') do
      with_tag('a[href=?]', edit_admin_category_path(@category), "back to edit category")
      with_tag('a[href=?]', admin_categories_path, "back to categories list")

    end
  end

end