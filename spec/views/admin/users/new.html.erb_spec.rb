require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/users/new" do
  before(:each) do
    @user = mock_model(User, :name=>nil, :email=>nil, :login=>nil, :password=>nil, :password_confirmation=>nil)

    # need to stub error object for my proper form ?

    assigns[:user] = @user
    assigns[:page_title] = "New User"
    
    render 'admin/users/new'
  end
  
  it "should display page title users" do
    response.should have_tag('h1', "New User")
  end
  
  it "should PUT to the user path" do
    response.should have_tag('form[action=?][method=?]', admin_users_path, :post)
  end
  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li input[type=?][id=?]', "text", "user_name")
      with_tag('li input[type=?][id=?]', "text", "user_login")
      with_tag('li input[type=?][id=?]', "text", "user_email")
    end
  end
  it "should display submit button" do
    response.should have_tag('form fieldset.submit') do
      with_tag('input[value=?]', "Create")
    end
  end

  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_users_path, "back to users list")
    end
  end

end