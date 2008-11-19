require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/categories/xx/edit" do
  before(:each) do
    @image = mock_model( CategoryImage, :id => 1, :category_id => 1, :to_param => 1) 
    @image.stub!(:public_filename).with(:thumb).and_return('image1.jpg')
    @category = mock_model(Category,
      :id => 1,
      :to_param => 1,
      :name=>"CategoryName",
      :title=>"Title",
      :description=>"Description",
      :featured => true,
      :image => @image
    )

    # need to stub error object for my proper form ?

    assigns[:image] = @category.image
    assigns[:category] = @category
    assigns[:page_title] = "Edit " + @category.name
    
    render 'admin/categories/edit'
  end
  
  it "should display page title categories" do
    response.should have_tag('h1', "Edit #{@category.name}")
  end
  
  it "should PUT to the category path" do
    response.should have_tag('form[action=?][method=?]', admin_category_path(@category), :post) do
      with_tag("input[type=hidden][name=_method][value=?]", "put")
    end
  end
  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li input[type=?][id=?]', "text", "category_name")
      with_tag('li input[type=?][id=?]', "text", "category_title")
      with_tag('li input[type=?][id=?]', "checkbox", "category_featured")
      with_tag('li textarea[id=?]', "category_description")
    end
  end
  it "should display submit button" do
    response.should have_tag('form fieldset.submit') do
      with_tag('input[value=?]', "Update")
    end
  end

  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_categories_path, "back to categories list")
    end
  end

  it "should show images" do
    content_for(:sub).should have_tag('ul.images') do
      with_tag('li img[src=?]', "image1.jpg")
    end
  end
  
  it "should show button to destroy image" do
    content_for(:sub).should have_tag('ul.images li') do
      with_tag('form[action=?] input[value=?]', admin_category_image_path(@category), "Delete")
      with_tag('input[name=?][type=?][value=?]', "_method", "hidden", "delete")
    end    
  end

  it "should have a link to new images" do
    content_for(:sub).should have_tag('a[href=?]', new_admin_category_image_path(@category), "Add a new image")
  end


end