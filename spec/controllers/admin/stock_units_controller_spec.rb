require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::StockUnitsController do
  fixtures :users

  before(:each) do
    login_as("tom")
    @params = {
      :product_id => "SKU"
    }
    @product = mock_model(Product, :id => 1, :to_param => "SKU", :sku => "SKU", :name => "ProductName", :images => [])
    Product.stub!(:find_by_sku).with(@params[:product_id]).and_return(@product)
  end

  describe "GET 'new' - /admin/products/xx/stock_units/new - " do

    before(:each) do
      @stock_unit = mock_model(StockUnit)
      StockUnit.stub!(:new).with(no_args).and_return(@stock_unit)
    end

    def do_get
      get :new, @params
    end

    it "should get the new stock_unit" do
      StockUnit.should_receive(:new).with(no_args).and_return(@stock_unit)
      do_get
    end
    it "should assign found order to @order for the view" do
      do_get
      assigns[:stock_unit].should == @stock_unit
    end
    it "should assign a page_title for the view" do
      do_get
      assigns[:page_title] == "New StockUnit"
    end
    

  end

  describe "GET 'edit' - /admin/products/xx/stock_units/xx/edit - " do

    before(:each) do
      @params.merge!({:id => "1"})
      @stock_unit = mock_model(StockUnit, :id => 1, :to_param => "1", :name => "name")
      StockUnit.stub!(:find).with("1").and_return(@stock_unit)
    end

    def do_get
      get :edit, @params
    end

    describe "with a valid stock_unit" do

      it "should get the stock_unit" do
        StockUnit.should_receive(:find).with("1").and_return(@stock_unit)
        do_get
      end
      it "should assign found stock_unit to @stock_unit for the view" do
        do_get
        assigns[:stock_unit].should == @stock_unit
      end
      it "should assign a page_title" do
        do_get
        assigns[:page_title].should == "Edit " + @stock_unit.name + " &#187; StockUnits"
      end
      
    end

    describe "with invalid stock_unit" do

      before(:each) do
        StockUnit.stub!(:find).with("1").and_return(nil)
      end

      it "should not get the stock_unit" do
        StockUnit.should_receive(:find).with("1").and_return(nil)
        do_get
      end
      it "should redirect to edit product page" do
        do_get
        response.should be_redirect
        response.should redirect_to(edit_admin_product_path(@product))
      end
    end

  end

  describe "POST 'create' - /admin/products/xx/stock_units/ - " do

    before(:each) do
      @params.merge!({
        :stock_unit => {
          "id" => "1"
        }
      })
      @stock_unit = mock_model(StockUnit, :id => 1, :to_param => "1")
      @stock_unit.stub!(:product=).with(@product).and_return(@product)
      StockUnit.stub!(:new).with(@params[:stock_unit]).and_return(@stock_unit)
      @stock_unit.stub!(:save).and_return(true)
    end

    def do_post
      post :create, @params
    end

    describe "with a valid stock_unit params" do

      it "should get the stock_unit" do
        StockUnit.should_receive(:new).with(@params[:stock_unit]).and_return(@stock_unit)
        do_post
      end
      it "should assign the product to stock unit" do
        @stock_unit.should_receive(:product=).with(@product).and_return(@product)
        do_post
      end
      it "should save the stock_unit object" do
        @stock_unit.should_receive(:save).and_return(true)
        do_post
      end
      it "should set the flash notice" do
        do_post
        flash[:notice].should == "StockUnit created successfully"
      end
      it "should redirect to the edit product page" do
        do_post
        response.should be_redirect
        response.should redirect_to(edit_admin_product_path(@product))
      end
        
    end

    describe "with invalid stock_unit" do

      before(:each) do
        @stock_unit.stub!(:save).and_return(false)
      end

      it "should set the flash error" do
        do_post
        flash[:error].should == "Could not create StockUnit"
      end
      it "should render the new action" do
        do_post
        response.should render_template("new")
      end
    end

  end

  describe "PUT 'update' - /admin/products/xx/stock_units/xx - " do

    before(:each) do
      @params.merge!({
        :id => "1",
        :stock_unit => {
          "id" => "1"
        }
      })
      @stock_unit = mock_model(StockUnit, :id => 1, :to_param => "1")
      StockUnit.stub!(:find).with("1").and_return(@stock_unit)
      @stock_unit.stub!(:update_attributes).with(@params[:stock_unit]).and_return(true)
    end

    def do_put
      put :update, @params
    end

    describe "with a valid stock_unit and params" do

      it "should get the stock_unit" do
        StockUnit.should_receive(:find).with("1").and_return(@stock_unit)
        do_put
      end
      it "should save the stock_unit object" do
        @stock_unit.should_receive(:update_attributes).with(@params[:stock_unit]).and_return(true)
        do_put
      end
      it "should set the flash notice" do
        do_put
        flash[:notice].should == "StockUnit updated successfully"
      end
      it "should redirect to the edit product page" do
        do_put
        response.should be_redirect
        response.should redirect_to(edit_admin_product_path(@product))
      end
        
    end

    describe "with invalid stock_unit params" do

      before(:each) do
        @stock_unit.stub!(:update_attributes).with(@params[:stock_unit]).and_return(false)
      end

      it "should set the flash error" do
        do_put
        flash[:error].should == "StockUnit could not be updated"
      end
      it "should render the edit action" do
        do_put
        response.should render_template("edit")
      end
    end

    describe "with invalid stock_unit" do

      before(:each) do
        StockUnit.stub!(:find).with("1").and_return(nil)
      end

      it "should not get the stock_unit" do
        StockUnit.should_receive(:find).with("1").and_return(nil)
        do_put
      end
      it "should set the flash error" do
        do_put
        flash[:error].should == "StockUnit could not be found"
      end
      it "should redirect to edit product page" do
        do_put
        response.should be_redirect
        response.should redirect_to(edit_admin_product_path(@product))
      end
    end

  end

  describe "DELETE 'destroy' - /admin/products/xx/stock_units/xx - " do

    before(:each) do
      @params.merge!({:id => "1"})
      @stock_unit = mock_model(StockUnit, :id => 1, :to_param => "1", :name => "name")
      @stock_unit.stub!(:destroy).and_return(true)
      StockUnit.stub!(:find).with("1").and_return(@stock_unit)
    end

    def do_delete
      delete :destroy, @params
    end

    describe "with a valid stock_unit and successful deletion" do

      it "should get the stock_unit" do
        StockUnit.should_receive(:find).with("1").and_return(@stock_unit)
        do_delete
      end
      it "should destroy the object" do
        @stock_unit.should_receive(:destroy).and_return(true)
        do_delete
      end
      it "should set the flash notice" do
        do_delete
        flash[:notice].should == "StockUnit destroyed"
      end
      it "should redirect to the edit product page" do
        do_delete
        response.should be_redirect
        response.should redirect_to(edit_admin_product_path(@product))
      end
      
    end

    describe "with a valid stock_unit and no deletion" do
      before(:each) do
        @stock_unit.stub!(:destroy).and_return(false)
      end

      it "should not destroy the object" do
        @stock_unit.should_receive(:destroy).and_return(false)
        do_delete
      end
      it "should set the flash error" do
        do_delete
        flash[:error].should == "Could not destroy StockUnit"
      end
      it "should redirect to the edit product page" do
        do_delete
        response.should be_redirect
        response.should redirect_to(edit_admin_product_path(@product))
      end
      
    end

    describe "with invalid stock_unit" do

      before(:each) do
        StockUnit.stub!(:find).with("1").and_return(nil)
      end

      it "should not get the stock_unit" do
        StockUnit.should_receive(:find).with("1").and_return(nil)
        do_delete
      end
      it "should set the flash error" do
        do_delete
        flash[:error].should == "Could not find StockUnit to destroy"
      end
      it "should redirect to edit product page" do
        do_delete
        response.should be_redirect
        response.should redirect_to(edit_admin_product_path(@product))
      end
    end

  end


end
