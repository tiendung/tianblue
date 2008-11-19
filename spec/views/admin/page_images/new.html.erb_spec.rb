require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/pages/x/image/new" do
  before(:each) do
    Page.stub!(:find_by_permalink).and_return(@page = mock_model(Page, :Title=>"PageTitle", :to_param => "pagetitle"))

    # need to stub error object for my proper form
    # @errors = mock_model(Object)
    # @errors.stub!(:on).with(any_args).and_return(nil)
    # @category.stub!(:errors).and_return(@errors)

    assigns[:page] = @page
    assigns[:page_title] = "New Image for PageTitle"
    
    render 'admin/page_images/new'
  end
  
  it "should display page title" do
    response.should have_tag('h1', "New Image for PageTitle")
  end
  
  it "should PUT to the page path" do
    response.should have_tag('form[action=?][method=?]', admin_page_image_path(@page), :post)
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
      with_tag('a[href=?]', edit_admin_page_path(@page), "back to edit page")
      with_tag('a[href=?]', admin_pages_path, "back to pages list")

    end
  end

end