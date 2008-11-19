require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::PagesController do
  fixtures :users

  before(:each) do
    login_as("tom")
  end

  describe "GET 'index' - /admin/pages -" do

    def do_get
      get :index
    end

    before(:each) do
      @page1 = mock_model(Page, :id => 1, :to_param => "name", :name => "name")
      @page2 = mock_model(Page, :id => 2, :to_param => "name2", :name => "name2")
      @pages = [@page1, @page2]
      Page.stub!(:all).and_return(@pages)
    end

    it "should find all pages" do
      Page.should_receive(:all).and_return(@pages)
      do_get
    end
    it "should assign to @pages for the view" do
      do_get
      assigns[:pages].should == [@page1, @page2]
    end
    it "should set a page_title for the view" do
      do_get
      assigns[:page_title].should == "Pages"
    end

  end

  describe "GET 'new' - /admin/pages/new - " do

    before(:each) do
      @page = mock_model(Page)
      Page.stub!(:new).with(no_args).and_return(@page)
    end

    def do_get
      get :new
    end

    it "should get the new page" do
      Page.should_receive(:new).with(no_args).and_return(@page)
      do_get
    end
    it "should assign found order to @order for the view" do
      do_get
      assigns[:page].should == @page
    end
    it "should assign a page_title for the view" do
      do_get
      assigns[:page_title] == "New Page"
    end
    

  end

  describe "GET 'edit' - /admin/pages/xx/edit - " do

    before(:each) do
      @page = mock_model(Page, :id => 1, :to_param => "name", :name => "name", :image => mock_model(CategoryImage))
      Page.stub!(:find_by_permalink).with("name").and_return(@page)
    end

    def do_get
      get :edit, :id => "name"
    end

    describe "with a valid page" do

      it "should get the page" do
        Page.should_receive(:find_by_permalink).with("name").and_return(@page)
        do_get
      end
      it "should assign found page to @page for the view" do
        do_get
        assigns[:page].should == @page
      end
      it "should return referenced image" do
        do_get
        assigns[:image].should == @page.image
      end
      it "should assign a page_title" do
        do_get
        assigns[:page_title].should == "Edit " + @page.name + " &#187; Pages"
      end
      
    end

    describe "with invalid page" do

      before(:each) do
        Page.stub!(:find_by_permalink).with("name").and_return(nil)
      end

      it "should not get the page" do
        Page.should_receive(:find_by_permalink).with("name").and_return(nil)
        do_get
      end
      it "should redirect to index" do
        do_get
        response.should be_redirect
        response.should redirect_to(admin_pages_path)
      end
    end

  end

  describe "POST 'create' - /admin/pages/ - " do

    before(:each) do
      @params = {
        :page => {
          "name" => "name",
          "body" => "Body"
        }
      }
      @page = mock_model(Page, :id => 1, :to_param => "name", :name => "name")
      Page.stub!(:new).with(@params[:page]).and_return(@page)
      @page.stub!(:save).and_return(true)
    end

    def do_post
      post :create, @params
    end

    describe "with a valid page params" do

      it "should get the page" do
        Page.should_receive(:new).with(@params[:page]).and_return(@page)
        do_post
      end
      it "should save the page object" do
        @page.should_receive(:save).and_return(true)
        do_post
      end
      it "should set the flash notice" do
        do_post
        flash[:notice].should == @page.name + " created successfully"
      end
      it "should redirect to the page index" do
        do_post
        response.should be_redirect
        response.should redirect_to(admin_pages_path)
      end
        
    end

    describe "with invalid page" do

      before(:each) do
        @page.stub!(:save).and_return(false)
      end

      it "should set the flash error" do
        do_post
        flash[:error].should == "Could not create page"
      end
      it "should render the new action" do
        do_post
        response.should render_template("new")
      end
    end

  end

  describe "PUT 'update' - /admin/pages/xx - " do

    before(:each) do
      @params = {
        :id => "name",
        :page => {
          "name" => "name"
        }
      }
      @page = mock_model(Page, :id => 1, :to_param => "name", :name => "name")
      Page.stub!(:find_by_permalink).with("name").and_return(@page)
      @page.stub!(:update_attributes).with(@params[:page]).and_return(true)
    end

    def do_put
      put :update, @params
    end

    describe "with a valid page and params" do

      it "should get the page" do
        Page.should_receive(:find_by_permalink).with("name").and_return(@page)
        do_put
      end
      it "should save the page object" do
        @page.should_receive(:update_attributes).with(@params[:page]).and_return(true)
        do_put
      end
      it "should set the flash notice" do
        do_put
        flash[:notice].should == "name updated successfully"
      end
      it "should redirect to the page index" do
        do_put
        response.should be_redirect
        response.should redirect_to(admin_pages_path)
      end
        
    end

    describe "with invalid page params" do

      before(:each) do
        @page.stub!(:update_attributes).with(@params[:page]).and_return(false)
      end

      it "should set the flash error" do
        do_put
        flash[:error].should == "Page could not be updated"
      end
      it "should render the edit action" do
        do_put
        response.should render_template("edit")
      end
    end

    describe "with invalid page" do

      before(:each) do
        Page.stub!(:find_by_permalink).with("name").and_return(nil)
      end

      it "should not get the page" do
        Page.should_receive(:find_by_permalink).with("name").and_return(nil)
        do_put
      end
      it "should set the flash error" do
        do_put
        flash[:error].should == "Page could not be found"
      end
      it "should redirect to index" do
        do_put
        response.should be_redirect
        response.should redirect_to(admin_pages_path)
      end
    end

  end

  describe "DELETE 'destroy' - /admin/pages/xx - " do

    before(:each) do
      @page = mock_model(Page, :id => 1, :to_param => "name", :name => "name")
      @page.stub!(:destroy).and_return(true)
      Page.stub!(:find_by_permalink).with("name").and_return(@page)
    end

    def do_delete
      delete :destroy, :id => "name"
    end

    describe "with a valid page and successful deletion" do

      it "should get the page" do
        Page.should_receive(:find_by_permalink).with("name").and_return(@page)
        do_delete
      end
      it "should destroy the object" do
        @page.should_receive(:destroy).and_return(true)
        do_delete
      end
      it "should set the flash notice" do
        do_delete
        flash[:notice].should == "Page destroyed"
      end
      it "should redirect to the page index" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_pages_path)
      end
      
    end

    describe "with a valid page and no deletion" do
      before(:each) do
        @page.stub!(:destroy).and_return(false)
      end

      it "should not destroy the object" do
        @page.should_receive(:destroy).and_return(false)
        do_delete
      end
      it "should set the flash error" do
        do_delete
        flash[:error].should == "Could not destroy page"
      end
      it "should redirect to the page index" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_pages_path)
      end
      
    end

    describe "with invalid page" do

      before(:each) do
        Page.stub!(:find_by_permalink).with("name").and_return(nil)
      end

      it "should not get the page" do
        Page.should_receive(:find_by_permalink).with("name").and_return(nil)
        do_delete
      end
      it "should set the flash error" do
        do_delete
        flash[:error].should == "Could not find page to destroy"
      end
      it "should redirect to index" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_pages_path)
      end
    end

  end


end
