require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::CategoriesController do
  fixtures :users

  before(:each) do
    login_as("tom")
  end

  describe "GET 'index' - /admin/categories -" do

    def do_get
      get :index
    end

    before(:each) do
      @category1 = mock_model(Category, :id => 1, :to_param => 1, :name => "CategoryName1")
      @category2 = mock_model(Category, :id => 2, :to_param => 2, :name => "CategoryName2")
      @categories = [@category1, @category2]
      Category.stub!(:all).and_return(@categories)
    end

    it "should find all categories" do
      Category.should_receive(:all).and_return(@categories)
      do_get
    end
    it "should assign to @categories for the view" do
      do_get
      assigns[:categories].should == [@category1, @category2]
    end
    it "should set a page_title for the view" do
      do_get
      assigns[:page_title].should == "Categories"
    end

  end

  # describe "GET 'show' - /admin/categories/xx - " do
  # 
  #   before(:each) do
  #     @category = mock_model(Category, :id => 1, :to_param => 1, :name => "CategoryName")
  #     Category.stub!(:find).with("1").and_return(@category)
  #   end
  # 
  #   def do_get
  #     get :show, :id => 1
  #   end
  # 
  #   describe "with a valid category" do
  # 
  #     it "should get the category" do
  #       Category.should_receive(:find).with("1").and_return(@category)
  #       do_get
  #     end
  #     it "should assign found order to @order for the view" do
  #       do_get
  #       assigns[:category].should == @category
  #     end
  #     it "should find products in category"
  #     it "should assign products to @product for the view"
  #   end
  # 
  #   describe "with invalid category" do
  # 
  #     before(:each) do
  #       Category.stub!(:find).with("1").and_return(nil)
  #     end
  # 
  #     it "should not get the category" do
  #       Category.should_receive(:find).with("1").and_return(nil)
  #       do_get
  #     end
  #     it "should redirect to index" do
  #       do_get
  #       response.should be_redirect
  #       response.should redirect_to(admin_categories_path)
  #     end
  #   end
  # 
  # 
  # end
  # 
  describe "GET 'new' - /admin/categories/new - " do

    before(:each) do
      @category = mock_model(Category)
      Category.stub!(:new).with(no_args).and_return(@category)
    end

    def do_get
      get :new
    end

    it "should get the new category" do
      Category.should_receive(:new).with(no_args).and_return(@category)
      do_get
    end
    it "should assign found order to @order for the view" do
      do_get
      assigns[:category].should == @category
    end

  end

  describe "GET 'edit' - /admin/categories/xx/edit - " do

    before(:each) do
      @category = mock_model(Category, :id => 1, :to_param => 1, :name => "CategoryName", :image => mock_model(CategoryImage))
      Category.stub!(:find_by_name).with("1").and_return(@category)
    end

    def do_get
      get :edit, :id => 1
    end

    describe "with a valid category" do

      it "should get the category" do
        Category.should_receive(:find_by_name).with("1").and_return(@category)
        do_get
      end
      it "should assign found order to @order for the view" do
        do_get
        assigns[:category].should == @category
      end
      it "should return referenced image" do
        do_get
        assigns[:image].should == @category.image
      end
      it "should assign and page title" do
        do_get
        assigns[:page_title].should == "Edit " + @category.name
      end
      
    end

    describe "with invalid category" do

      before(:each) do
        Category.stub!(:find_by_name).with("1").and_return(nil)
      end

      it "should not get the category" do
        Category.should_receive(:find_by_name).with("1").and_return(nil)
        do_get
      end
      it "should redirect to index" do
        do_get
        response.should be_redirect
        response.should redirect_to(admin_categories_path)
      end
    end

  end

  describe "POST 'create' - /admin/categories/ - " do

    before(:each) do
      @params = {
        :category => {
          "name" => "CategoryName"
        }
      }
      @category = mock_model(Category, :id => 1, :to_param => 1, :name => "CategoryName")
      Category.stub!(:new).with(@params[:category]).and_return(@category)
      @category.stub!(:save).and_return(true)
    end

    def do_post
      post :create, @params
    end

    describe "with a valid category params" do

      it "should get the category" do
        Category.should_receive(:new).with(@params[:category]).and_return(@category)
        do_post
      end
      it "should save the category object" do
        @category.should_receive(:save).and_return(true)
        do_post
      end
      it "should set the flash notice" do
        do_post
        flash[:notice].should == "Category created"
      end
      it "should redirect to the category index" do
        do_post
        response.should be_redirect
        response.should redirect_to(admin_categories_path)
      end
        
    end

    describe "with invalid category" do

      before(:each) do
        @category.stub!(:save).and_return(false)
      end

      it "should set the flash error" do
        do_post
        flash[:error].should == "Could not create category"
      end
      it "should render the new action" do
        do_post
        response.should render_template("new")
      end
    end

  end

  describe "PUT 'update' - /admin/categories/xx - " do

    before(:each) do
      @params = {
        :id => "1",
        :category => {
          "name" => "CategoryName"
        }
      }
      @category = mock_model(Category, :id => 1, :to_param => 1, :name => "CategoryName")
      Category.stub!(:find_by_name).with("1").and_return(@category)
      @category.stub!(:update_attributes).with(@params[:category]).and_return(true)
    end

    def do_put
      put :update, @params
    end

    describe "with a valid category and params" do

      it "should get the category" do
        Category.should_receive(:find_by_name).with("1").and_return(@category)
        do_put
      end
      it "should save the category object" do
        @category.should_receive(:update_attributes).with(@params[:category]).and_return(true)
        do_put
      end
      it "should set the flash notice" do
        do_put
        flash[:notice].should == "Category updated"
      end
      it "should redirect to the category index" do
        do_put
        response.should be_redirect
        response.should redirect_to(admin_categories_path)
      end
        
    end

    describe "with invalid category params" do

      before(:each) do
        @category.stub!(:update_attributes).with(@params[:category]).and_return(false)
      end

      it "should set the flash error" do
        do_put
        flash[:error].should == "Could not update category"
      end
      it "should render the edit action" do
        do_put
        response.should render_template("edit")
      end
    end

    describe "with invalid category" do

      before(:each) do
        Category.stub!(:find_by_name).with("1").and_return(nil)
      end

      it "should not get the category" do
        Category.should_receive(:find_by_name).with("1").and_return(nil)
        do_put
      end
      it "should redirect to index" do
        do_put
        response.should be_redirect
        response.should redirect_to(admin_categories_path)
      end
    end

  end

end
