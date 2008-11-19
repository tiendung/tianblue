require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/users/xx/edit" do
  before(:each) do
    @user = mock_model(User,
      :id => 1,
      :to_param => 1,
      :login=>"username",
      :name=>"User Name",
      :email=>"name@email.com",
      :is_admin=>true
    )

    assigns[:user] = @user
    assigns[:page_title] = "Edit " + @user.name
    
    render 'admin/users/edit'
  end
  
  it "should display page title users" do
    response.should have_tag('h1', "Edit #{@user.name}")
  end
  it "should PUT to the user path" do
    response.should have_tag('form[action=?][method=?]', admin_user_path(@user), :post) do
      with_tag("input[type=hidden][name=_method][value=?]", "put")
    end
  end
  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li input[type=?][id=?]', "text", "user_login")
      with_tag('li input[type=?][id=?]', "text", "user_name")
      with_tag('li input[type=?][id=?]', "text", "user_email")
      with_tag('li input[type=?][id=?]', "checkbox", "user_is_admin")
    end
  end
  it "should display submit button" do
    response.should have_tag('form fieldset.submit') do
      with_tag('input[value=?]', "Update")
    end
  end
  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_users_path, "back to users list")
    end
  end

end