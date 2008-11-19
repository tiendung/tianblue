require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::SizesController do
  fixtures :users

  before(:each) do
    login_as("tom")
  end

  describe "GET 'index' - /admin/sizes -" do

    def do_get
      get :index
    end

    before(:each) do
      @size1 = mock_model(Size, :id => 1, :to_param => "m", :name => "Medium")
      @size2 = mock_model(Size, :id => 2, :to_param => "l", :name => "Large")
      @sizes = [@size1, @size2]
      Size.stub!(:all).and_return(@sizes)
    end

    it "should find all sizes" do
      Size.should_receive(:all).and_return(@sizes)
      do_get
    end
    it "should assign to @sizes for the view" do
      do_get
      assigns[:sizes].should == [@size1, @size2]
    end
    it "should set a page_title for the view" do
      do_get
      assigns[:page_title].should == "Sizes"
    end

  end

  describe "GET 'new' - /admin/sizes/new - " do

    before(:each) do
      @size = mock_model(Size)
      Size.stub!(:new).with(no_args).and_return(@size)
    end

    def do_get
      get :new
    end

    it "should get the new size" do
      Size.should_receive(:new).with(no_args).and_return(@size)
      do_get
    end
    it "should assign found order to @order for the view" do
      do_get
      assigns[:size].should == @size
    end
    it "should assign a page_title for the view" do
      do_get
      assigns[:page_title] == "New Size"
    end
    

  end

  describe "GET 'edit' - /admin/sizes/xx/edit - " do

    before(:each) do
      @size = mock_model(Size, :id => 1, :to_param => "m", :name => "Medium")
      Size.stub!(:find_by_code).with("m").and_return(@size)
    end

    def do_get
      get :edit, :id => "m"
    end

    describe "with a valid size" do

      it "should get the size" do
        Size.should_receive(:find_by_code).with("m").and_return(@size)
        do_get
      end
      it "should assign found order to @order for the view" do
        do_get
        assigns[:size].should == @size
      end
      it "should assign and page title" do
        do_get
        assigns[:page_title].should == "Edit " + @size.name
      end
      
    end

    describe "with invalid size" do

      before(:each) do
        Size.stub!(:find_by_code).with("m").and_return(nil)
      end

      it "should not get the size" do
        Size.should_receive(:find_by_code).with("m").and_return(nil)
        do_get
      end
      it "should redirect to index" do
        do_get
        response.should be_redirect
        response.should redirect_to(admin_sizes_path)
      end
    end

  end

  describe "POST 'create' - /admin/sizes/ - " do

    before(:each) do
      @params = {
        :size => {
          "code" => "Medium",
          "name" => "m",
          "description" => "Description of the size"
        }
      }
      @size = mock_model(Size, :id => 1, :to_param => "m", :name => "Medium")
      Size.stub!(:new).with(@params[:size]).and_return(@size)
      @size.stub!(:save).and_return(true)
    end

    def do_post
      post :create, @params
    end

    describe "with a valid size params" do

      it "should get the size" do
        Size.should_receive(:new).with(@params[:size]).and_return(@size)
        do_post
      end
      it "should save the size object" do
        @size.should_receive(:save).and_return(true)
        do_post
      end
      it "should set the flash notice" do
        do_post
        flash[:notice].should == "Size created"
      end
      it "should redirect to the size index" do
        do_post
        response.should be_redirect
        response.should redirect_to(admin_sizes_path)
      end
        
    end

    describe "with invalid size" do

      before(:each) do
        @size.stub!(:save).and_return(false)
      end

      it "should set the flash error" do
        do_post
        flash[:error].should == "Could not create size"
      end
      it "should render the new action" do
        do_post
        response.should render_template("new")
      end
    end

  end

  describe "PUT 'update' - /admin/sizes/xx - " do

    before(:each) do
      @params = {
        :id => "m",
        :size => {
          "name" => "Medium"
        }
      }
      @size = mock_model(Size, :id => 1, :to_param => "m", :name => "Medium")
      Size.stub!(:find_by_code).with("m").and_return(@size)
      @size.stub!(:update_attributes).with(@params[:size]).and_return(true)
    end

    def do_put
      put :update, @params
    end

    describe "with a valid size and params" do

      it "should get the size" do
        Size.should_receive(:find_by_code).with("m").and_return(@size)
        do_put
      end
      it "should save the size object" do
        @size.should_receive(:update_attributes).with(@params[:size]).and_return(true)
        do_put
      end
      it "should set the flash notice" do
        do_put
        flash[:notice].should == "Size updated"
      end
      it "should redirect to the size index" do
        do_put
        response.should be_redirect
        response.should redirect_to(admin_sizes_path)
      end
        
    end

    describe "with invalid size params" do

      before(:each) do
        @size.stub!(:update_attributes).with(@params[:size]).and_return(false)
      end

      it "should set the flash error" do
        do_put
        flash[:error].should == "Could not update size"
      end
      it "should render the edit action" do
        do_put
        response.should render_template("edit")
      end
    end

    describe "with invalid size" do

      before(:each) do
        Size.stub!(:find_by_code).with("m").and_return(nil)
      end

      it "should not get the size" do
        Size.should_receive(:find_by_code).with("m").and_return(nil)
        do_put
      end
      it "should redirect to index" do
        do_put
        response.should be_redirect
        response.should redirect_to(admin_sizes_path)
      end
    end

  end

  describe "DELETE 'destroy' - /admin/sizes/xx - " do

    before(:each) do
      @size = mock_model(Size, :id => 1, :to_param => "m", :name => "Medium")
      @size.stub!(:destroy).and_return(true)
      Size.stub!(:find_by_code).with("m").and_return(@size)
    end

    def do_delete
      delete :destroy, :id => "m"
    end

    describe "with a valid size and successful deletion" do

      it "should get the size" do
        Size.should_receive(:find_by_code).with("m").and_return(@size)
        do_delete
      end
      it "should destroy the object" do
        @size.should_receive(:destroy).and_return(true)
        do_delete
      end
      it "should set the flash notice" do
        do_delete
        flash[:notice].should == "Size destroyed"
      end
      it "should redirect to the size index" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_sizes_path)
      end
      
    end

    describe "with a valid size and no deletion" do
      before(:each) do
        @size.stub!(:destroy).and_return(false)
      end

      it "should not destroy the object" do
        @size.should_receive(:destroy).and_return(false)
        do_delete
      end
      it "should set the flash error" do
        do_delete
        flash[:error].should == "Could not destroy #{@size.name}"
      end
      it "should redirect to the size index" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_sizes_path)
      end
      
    end

    describe "with invalid size" do

      before(:each) do
        Size.stub!(:find_by_code).with("m").and_return(nil)
      end

      it "should not get the size" do
        Size.should_receive(:find_by_code).with("m").and_return(nil)
        do_delete
      end
      it "should redirect to index" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_sizes_path)
      end
    end

  end


  # describe "GET 'show' - /admin/sizes/xx - " do
  # 
  #   before(:each) do
  #     @size = mock_model(Size, :id => 1, :to_param => 1, :name => "SizeName")
  #     Size.stub!(:find).with("1").and_return(@size)
  #   end
  # 
  #   def do_get
  #     get :show, :id => 1
  #   end
  # 
  #   describe "with a valid size" do
  # 
  #     it "should get the size" do
  #       Size.should_receive(:find).with("1").and_return(@size)
  #       do_get
  #     end
  #     it "should assign found order to @order for the view" do
  #       do_get
  #       assigns[:size].should == @size
  #     end
  #     it "should find products in size"
  #     it "should assign products to @product for the view"
  #   end
  # 
  #   describe "with invalid size" do
  # 
  #     before(:each) do
  #       Size.stub!(:find).with("1").and_return(nil)
  #     end
  # 
  #     it "should not get the size" do
  #       Size.should_receive(:find).with("1").and_return(nil)
  #       do_get
  #     end
  #     it "should redirect to index" do
  #       do_get
  #       response.should be_redirect
  #       response.should redirect_to(admin_sizes_path)
  #     end
  #   end
  # 
  # 
  # end

end
