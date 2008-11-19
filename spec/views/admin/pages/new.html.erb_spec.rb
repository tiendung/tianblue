require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/pages/new" do
  before(:each) do
    Page.stub!(:new).and_return(@page = mock_model(Page, :name=>nil, :body=>nil, :permalink=>nil ))

    # need to stub error object for my proper form

    assigns[:page] = @page
    assigns[:page_title] = "New Page"
    
    render 'admin/pages/new'
  end
  
  it "should display page name pages" do
    response.should have_tag('h1', "New Page")
  end
  
  it "should PUT to the page path" do
    response.should have_tag('form[action=?][method=?]', admin_pages_path, :post)
  end

  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li input[type=?][id=?]', "text", "page_name")
      with_tag('li textarea[id=?]', "page_body")
      with_tag('li input[type=?][id=?]', "text", "page_permalink")
    end
  end
  
  it "should display submit button" do
    response.should have_tag('form fieldset.submit') do
      with_tag('input[value=?]', "Create")
    end
  end
      
  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_pages_path, "back to pages list")
    end
  end

end