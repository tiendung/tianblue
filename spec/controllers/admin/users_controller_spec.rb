require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::UsersController do
  fixtures :users

  before(:each) do
    login_as("tom")
  end

  describe "GET 'index' - /admin/users -" do

    def do_get
      get :index
    end

    before(:each) do
      @user1 = mock_model(User, :id => 1, :to_param => "m", :name => "Medium")
      @user2 = mock_model(User, :id => 2, :to_param => "l", :name => "Large")
      @users = [@user1, @user2]
      User.stub!(:all).and_return(@users)
    end

    it "should find all users" do
      User.should_receive(:all).with(:order=>"login ASC").and_return(@users)
      do_get
    end
    it "should assign to @users for the view" do
      do_get
      assigns[:users].should == [@user1, @user2]
    end
    it "should set a page_title for the view" do
      do_get
      assigns[:page_title].should == "Users"
    end

  end

  describe "GET 'new' - /admin/users/new - " do

    before(:each) do
      @user = mock_model(User)
      User.stub!(:new).with(no_args).and_return(@user)
    end

    def do_get
      get :new
    end

    it "should get the new user" do
      User.should_receive(:new).with(no_args).and_return(@user)
      do_get
    end
    it "should assign found order to @order for the view" do
      do_get
      assigns[:user].should == @user
    end
    it "should assign a page_title for the view" do
      do_get
      assigns[:page_title] == "New User"
    end
    

  end

  describe "GET 'edit' - /admin/users/xx/edit - " do

    before(:each) do
      @user = mock_model(User, :id => 1, :to_param => "m", :name => "Medium")
      User.stub!(:find).with("m").and_return(@user)
    end

    def do_get
      get :edit, :id => "m"
    end

    describe "with a valid user" do

      it "should get the user" do
        User.should_receive(:find).with("m").and_return(@user)
        do_get
      end
      it "should assign found order to @order for the view" do
        do_get
        assigns[:user].should == @user
      end
      it "should assign and page title" do
        do_get
        assigns[:page_title].should == "Edit " + @user.name
      end
      
    end

    describe "with invalid user" do

      before(:each) do
        User.stub!(:find).with("m").and_return(nil)
      end

      it "should not get the user" do
        User.should_receive(:find).with("m").and_return(nil)
        do_get
      end
      it "should redirect to index" do
        do_get
        response.should be_redirect
        response.should redirect_to(admin_users_path)
      end
    end

  end

  describe "POST 'create' - /admin/users/ - " do

    before(:each) do
      @params = {
        :user => {
          "code" => "Medium",
          "name" => "m",
          "description" => "Description of the user"
        }
      }
      @user = mock_model(User, :id => 1, :to_param => "m", :name => "Medium")
      User.stub!(:new).with(@params[:user]).and_return(@user)
      @user.stub!(:save).and_return(true)
    end

    def do_post
      post :create, @params
    end

    describe "with a valid user params" do

      it "should get the user" do
        User.should_receive(:new).with(@params[:user]).and_return(@user)
        do_post
      end
      it "should save the user object" do
        @user.should_receive(:save).and_return(true)
        do_post
      end
      it "should set the flash notice" do
        do_post
        flash[:notice].should == "User created"
      end
      it "should redirect to the user index" do
        do_post
        response.should be_redirect
        response.should redirect_to(admin_users_path)
      end
        
    end

    describe "with invalid user" do

      before(:each) do
        @user.stub!(:save).and_return(false)
      end

      it "should set the flash error" do
        do_post
        flash[:error].should == "Could not create user"
      end
      it "should render the new action" do
        do_post
        response.should be_redirect
        response.should redirect_to(new_admin_user_path)
      end
    end

  end

  describe "PUT 'update' - /admin/users/xx - " do

    before(:each) do
      @params = {
        :id => "m",
        :user => {
          "name" => "Medium",
          "admin" => true
        }
      }
      @user = mock_model(User, :id => 1, :to_param => "m", :name => "Medium")
      User.stub!(:find).with("m").and_return(@user)
      @user.stub!(:update_attributes).with(@params[:user]).and_return(true)
    end

    def do_put
      put :update, @params
    end

    describe "with a valid user and params" do

      it "should get the user" do
        User.should_receive(:find).with("m").and_return(@user)
        do_put
      end
      it "should save the user object" do
        @user.should_receive(:update_attributes).with(@params[:user]).and_return(true)
        do_put
      end
      it "should set the flash notice" do
        do_put
        flash[:notice].should == "User updated"
      end
      it "should redirect to the user index" do
        do_put
        response.should be_redirect
        response.should redirect_to(admin_users_path)
      end
        
    end

    describe "with invalid user params" do

      before(:each) do
        @user.stub!(:update_attributes).with(@params[:user]).and_return(false)
      end

      it "should set the flash error" do
        do_put
        flash[:error].should == "Could not update user"
      end
      it "should render the edit action" do
        do_put
        response.should redirect_to(edit_admin_user_path(@user))
      end
    end

    describe "with invalid user" do

      before(:each) do
        User.stub!(:find).with("m").and_return(nil)
      end

      it "should not get the user" do
        User.should_receive(:find).with("m").and_return(nil)
        do_put
      end
      it "should redirect to index" do
        do_put
        response.should be_redirect
        response.should redirect_to(admin_users_path)
      end
    end

  end

  describe "DELETE 'destroy' - /admin/users/xx - " do

    before(:each) do
      @user = mock_model(User, :id => 1, :to_param => "m", :name => "Medium")
      @user.stub!(:destroy).and_return(true)
      User.stub!(:find).with("m").and_return(@user)
    end

    def do_delete
      delete :destroy, :id => "m"
    end

    describe "with a valid user and successful deletion" do

      it "should get the user" do
        User.should_receive(:find).with("m").and_return(@user)
        do_delete
      end
      it "should destroy the object" do
        @user.should_receive(:destroy).and_return(true)
        do_delete
      end
      it "should set the flash notice" do
        do_delete
        flash[:notice].should == "User destroyed"
      end
      it "should redirect to the user index" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_users_path)
      end
      
    end

    describe "with a valid user and no deletion" do
      before(:each) do
        @user.stub!(:destroy).and_return(false)
      end

      it "should not destroy the object" do
        @user.should_receive(:destroy).and_return(false)
        do_delete
      end
      it "should set the flash error" do
        do_delete
        flash[:error].should == "Could not destroy #{@user.name}"
      end
      it "should redirect to the user index" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_users_path)
      end
      
    end

    describe "with invalid user" do

      before(:each) do
        User.stub!(:find).with("m").and_return(nil)
      end

      it "should not get the user" do
        User.should_receive(:find).with("m").and_return(nil)
        do_delete
      end
      it "should redirect to index" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_users_path)
      end
    end

  end

  # describe "GET 'show' - /admin/users/xx - " do
  # 
  #   before(:each) do
  #     @user = mock_model(User, :id => 1, :to_param => 1, :name => "UserName")
  #     User.stub!(:find).with("1").and_return(@user)
  #   end
  # 
  #   def do_get
  #     get :show, :id => 1
  #   end
  # 
  #   describe "with a valid user" do
  # 
  #     it "should get the user" do
  #       User.should_receive(:find).with("1").and_return(@user)
  #       do_get
  #     end
  #     it "should assign found order to @order for the view" do
  #       do_get
  #       assigns[:user].should == @user
  #     end
  #     it "should find products in user"
  #     it "should assign products to @product for the view"
  #   end
  # 
  #   describe "with invalid user" do
  # 
  #     before(:each) do
  #       User.stub!(:find).with("1").and_return(nil)
  #     end
  # 
  #     it "should not get the user" do
  #       User.should_receive(:find).with("1").and_return(nil)
  #       do_get
  #     end
  #     it "should redirect to index" do
  #       do_get
  #       response.should be_redirect
  #       response.should redirect_to(admin_users_path)
  #     end
  #   end
  # 
  # 
  # end

end
