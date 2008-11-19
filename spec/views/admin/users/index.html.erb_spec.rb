require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/users" do
  before(:each) do
    @users = [
      mock_model(User, :id => 1, :to_param => "1", :email => "name1@email.com", :login=>"login1", :name => "Name 1", :name? => true, :password= =>nil, :password=>nil, :password_confirmation= =>nil, :password_confirmation=>nil),
      mock_model(User, :id => 2, :to_param => "2", :email => "name2@email.com", :login=>"login2", :name? => false, :password= =>nil, :password=>nil, :password_confirmation= =>nil, :password_confirmation=>nil)
    ]

    assigns[:users] = @users
    assigns[:page_title] = "Users"
    
    render 'admin/users/index'
  end
  
  it "should display page title users" do
    response.should have_tag('h1', "Users")
  end
  it "should show each size in a tabular format" do
    response.should have_tag('table tbody tr', 2)
  end
  it "should show name if there is one" do
    response.should have_tag('tbody th', /Name 1/)
  end
  it "should show logins" do
    response.should have_tag('tbody th', /login1/)
    response.should have_tag('tbody th', /login2/)
  end
  it "should show email address" do
    response.should have_tag('tbody td', /name1@email\.com/)
    response.should have_tag('tbody td', /name2@email\.com/)
  end
  it "should show links to edit the order pages" do
    response.should have_tag('tbody th a[href=?]', edit_admin_user_path("1"))
    response.should have_tag('tbody tr+tr th a[href=?]', edit_admin_user_path("2"))
  end
  it "should link to new form" do
    response.should have_tag("a[href=?]", new_admin_user_path)
  end
      
end