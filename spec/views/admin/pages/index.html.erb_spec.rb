require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/pages with pages" do
  before(:each) do
    @page1 = mock_model( Page, :name => "Page1", :body => "Body 1", :to_param => "page1", :permalink => "page1" )
    @page2 = mock_model( Page, :name => "Page2", :body => "Body 2", :to_param => "page2", :permalink => "page2" )
    @page3 = mock_model( Page, :name => "Page3", :body => "Body 3", :to_param => "page3", :permalink => "page3" )

    assigns[:pages] = [@page1, @page2, @page3]
    
    render 'admin/pages/index'
  end
  
  it "should display page name pages" do
    response.should have_tag('h1', "Pages")
  end
  
  it "should display all the pages" do
    response.should have_tag('table tbody tr', 3)
  end
  
  it "should display names of all the pages" do
    response.should have_tag('table tbody tr th.text', /Page1 \(page1\)/)
    response.should have_tag('table tbody tr+tr th.text', /Page2 \(page2\)/)
    response.should have_tag('table tbody tr+tr+tr th.text', /Page3 \(page3\)/)
  end
  
  it "should link to each edit page" do
    response.should have_tag('table tbody tr th a[href=?]', edit_admin_page_path(@page1), "edit")
    response.should have_tag('table tbody tr+tr th a[href=?]', edit_admin_page_path(@page2), "edit")
    response.should have_tag('table tbody tr+tr+tr th a[href=?]', edit_admin_page_path(@page3), "edit")
  end
  
  it "should link to new page" do
    response.should have_tag('a[href=?]', new_admin_page_path, "new")
  end
      
end