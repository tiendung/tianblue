require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/pages/xx/edit" do
  before(:each) do
    @image = mock_model( PageImage, :id => 1, :page_id => 1, :to_param => 1) 
    @image.stub!(:public_filename).with(:thumb).and_return('image1.jpg')
    @page = mock_model(Page,
      :id => 1,
      :to_param => "page-name",
      :name => "Page Name",
      :body => "Body Text",
      :permalink => "page-name",
      :image => @image
    )
    
    assigns[:page] = @page
    assigns[:image] = @page.image
    assigns[:page_title] = "Edit " + @page.name + " &#187; Pages"
    
    render 'admin/pages/edit'
  end
  
  it "should display page name pages" do
    response.should have_tag('h1', "Edit Page Name &#187; Pages")
  end
  
  it "should PUT to the page path" do
    response.should have_tag('form[action=?]', admin_page_path(@page)) do
      with_tag('input[name=?][type=?][value=?]', "_method", "hidden", "put")
    end
  end
  
  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li input[type=?][id=?][value=?]', "text", "page_name", "Page Name")
      with_tag('li textarea[id=?]', "page_body")
      with_tag('li input[type=?][id=?][value=?]', "text", "page_permalink", "page-name")
    end
  end
  
  it "should display submit button" do
    response.should have_tag('form fieldset.submit') do
      with_tag('input[value=?]', "Update")
    end
  end
  
  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_pages_path, "back to pages list")
    end
  end
  
  it "should show images" do
    content_for(:sub).should have_tag('ul.images') do
      with_tag('li img[src=?]', "image1.jpg")
    end
  end
  
  it "should show button to destroy image" do
    content_for(:sub).should have_tag('ul.images li') do
      with_tag('form[action=?] input[value=?]', admin_page_image_path(@page), "Delete")
      with_tag('input[name=?][type=?][value=?]', "_method", "hidden", "delete")
    end    
  end

  it "should have a link to new images" do
    content_for(:sub).should have_tag('a[href=?]', new_admin_page_image_path(@page), "Add a new image")
  end
  
      
end