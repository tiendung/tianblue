# require File.dirname(__FILE__) + '/../spec_helper'
# 
# describe ApplicationController, "login from session" do
# 
#   class FooController < ApplicationController
#     before_filter :login_required
#     def index; render :text => "foos"; end
#   end
#   controller_name :foo
# 
#   before(:each) do
#     ActionController::Routing::Routes.draw do |map|
#       map.resources :foo
#       map.signin    '/signin', :controller => "sessions", :action => "new"
#       map.root      :controller => "products", :action => "index"
#     end
#     @user = mock_model(User, :id => 23)
#     session[:user] = 23
#     User.stub!(:find).with(session[:user]).and_return(@user)
#    end
# 
#   def do_get
#     get :index
#   end
# 
#   it "should assign the current user" do
#     do_get
#     assigns[:current_user].should_not be_blank
#     assigns[:current_user].should == @user
#   end
#   
#   it "should find the current user" do
#     User.should_receive(:find).with(session[:user]).and_return(@user)
#     do_get
#   end
#   
# end
# 
# describe ApplicationController, "login, but no session var set" do
# 
#   class FooController < ApplicationController
#     before_filter :login_required
#     def index; render :text => "foos"; end
#   end
#   controller_name :foo
# 
#   before(:each) do
#     ActionController::Routing::Routes.draw do |map|
#       map.resources :foo
#       map.signin    '/signin', :controller => "sessions", :action => "new"
#     end
#     session[:user] = nil
#     # User.stub!(:find).with(session[:user]).and_return(nil)
#    end
# 
#   def do_get
#     get :index
#   end
# 
#   it "should assign the current user" do
#     do_get
#     assigns[:current_user].should be_false
#   end
#   
#   it "should not try the current user" do
#     User.should_not_receive(:find).with(session[:user]).and_return(@user)
#     do_get
#   end
# 
#   it "should set session to return to current page" do
#     do_get
#     session[:return_to].should == "/foo"
#   end
#   
#   it "should redirect to the login page" do
#     do_get
#     response.should be_redirect
#     response.should redirect_to(signin_url)
#   end
#   
# end
# 
# describe ApplicationController, "login, but no user found" do
# 
#   class FooController < ApplicationController
#     before_filter :login_required
#     def index; render :text => "foos"; end
#   end
#   controller_name :foo
# 
#   before(:each) do
#     ActionController::Routing::Routes.draw do |map|
#       map.resources :foo
#       map.signin    '/signin', :controller => "sessions", :action => "new"
#       map.root      :controller => "products", :action => "index"
#     end
#     session[:user] = 25
#     User.stub!(:find).with(session[:user]).and_return(nil)
#    end
# 
#   def do_get
#     get :index
#   end
# 
#   it "should assign the current user" do
#     do_get
#     assigns[:current_user].should be_false
#   end
#   
#   it "should try the current user" do
#     User.should_receive(:find).with(session[:user]).and_return(@user)
#     do_get
#   end
# 
#   it "should set session to return to current page" do
#     do_get
#     session[:return_to].should == "/foo"
#   end
#   
#   it "should redirect to the login page" do
#     do_get
#     response.should be_redirect
#     response.should redirect_to(signin_url)
#   end
#   
# end
