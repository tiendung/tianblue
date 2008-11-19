require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::CountriesController do
  fixtures :users

  before(:each) do
    login_as("tom")
  end

  describe "GET 'index' - /admin/countries -" do

    def do_get
      get :index
    end

    before(:each) do
      @country1 = mock_model(Country, :id => 1, :to_param => 1, :name => "Name1")
      @country2 = mock_model(Country, :id => 2, :to_param => 2, :name => "Name2")
      @countries = [@country1, @country2]
      Country.stub!(:all).and_return(@countries)
    end

    it "should find all countries" do
      Country.should_receive(:all).and_return(@countries)
      do_get
    end
    it "should assign to @countries for the view" do
      do_get
      assigns[:countries].should == [@country1, @country2]
    end
    it "should set a page_title for the view" do
      do_get
      assigns[:page_title].should == "Countries"
    end

  end

  describe "GET 'new' - /admin/countries/new - " do

    before(:each) do
      @country = mock_model(Country)
      Country.stub!(:new).with(no_args).and_return(@country)
    end

    def do_get
      get :new
    end

    it "should get the new country" do
      Country.should_receive(:new).with(no_args).and_return(@country)
      do_get
    end
    it "should assign found order to @order for the view" do
      do_get
      assigns[:country].should == @country
    end
    it "should assign a page_title for the view" do
      do_get
      assigns[:page_title] == "New Country"
    end
    

  end

  describe "GET 'edit' - /admin/countries/xx/edit - " do

    before(:each) do
      @country = mock_model(Country, :id => 1, :to_param => "1", :name => "Name")
      Country.stub!(:find).with("1").and_return(@country)
    end

    def do_get
      get :edit, :id => "1"
    end

    describe "with a valid country" do

      it "should get the country" do
        Country.should_receive(:find).with("1").and_return(@country)
        do_get
      end
      it "should assign found order to @order for the view" do
        do_get
        assigns[:country].should == @country
      end
      it "should assign and page title" do
        do_get
        assigns[:page_title].should == "Edit " + @country.name
      end
      
    end

    describe "with invalid country" do

      before(:each) do
        Country.stub!(:find).with("1").and_return(nil)
      end

      it "should not get the country" do
        Country.should_receive(:find).with("1").and_return(nil)
        do_get
      end
      it "should redirect to index" do
        do_get
        response.should be_redirect
        response.should redirect_to(admin_countries_path)
      end
    end

  end

  describe "POST 'create' - /admin/countries/ - " do

    before(:each) do
      @params = {
        :country => {
          "name" => "Name"
        }
      }
      @country = mock_model(Country, :id => 1, :to_param => "1", :name => "Name")
      Country.stub!(:new).with(@params[:country]).and_return(@country)
      @country.stub!(:save).and_return(true)
    end

    def do_post
      post :create, @params
    end

    describe "with a valid country params" do

      it "should get the country" do
        Country.should_receive(:new).with(@params[:country]).and_return(@country)
        do_post
      end
      it "should save the country object" do
        @country.should_receive(:save).and_return(true)
        do_post
      end
      it "should set the flash notice" do
        do_post
        flash[:notice].should == "Country created"
      end
      it "should redirect to the country index" do
        do_post
        response.should be_redirect
        response.should redirect_to(admin_countries_path)
      end
        
    end

    describe "with invalid country" do

      before(:each) do
        @country.stub!(:save).and_return(false)
      end

      it "should set the flash error" do
        do_post
        flash[:error].should == "Could not create country"
      end
      it "should render the new action" do
        do_post
        response.should render_template("new")
      end
    end

  end

  describe "PUT 'update' - /admin/countries/xx - " do

    before(:each) do
      @params = {
        :id => "1",
        :country => {
          "name" => "Name"
        }
      }
      @country = mock_model(Country, :id => 1, :to_param => "1", :name => "Name")
      Country.stub!(:find).with("1").and_return(@country)
      @country.stub!(:update_attributes).with(@params[:country]).and_return(true)
    end

    def do_put
      put :update, @params
    end

    describe "with a valid country and params" do

      it "should get the country" do
        Country.should_receive(:find).with("1").and_return(@country)
        do_put
      end
      it "should save the country object" do
        @country.should_receive(:update_attributes).with(@params[:country]).and_return(true)
        do_put
      end
      it "should set the flash notice" do
        do_put
        flash[:notice].should == "Country updated"
      end
      it "should redirect to the country index" do
        do_put
        response.should be_redirect
        response.should redirect_to(admin_countries_path)
      end
        
    end

    describe "with invalid country params" do

      before(:each) do
        @country.stub!(:update_attributes).with(@params[:country]).and_return(false)
      end

      it "should set the flash error" do
        do_put
        flash[:error].should == "Could not update country"
      end
      it "should render the edit action" do
        do_put
        response.should render_template("edit")
      end
    end

    describe "with invalid country" do

      before(:each) do
        Country.stub!(:find).with("1").and_return(nil)
      end

      it "should not get the country" do
        Country.should_receive(:find).with("1").and_return(nil)
        do_put
      end
      it "should redirect to index" do
        do_put
        response.should be_redirect
        response.should redirect_to(admin_countries_path)
      end
    end

  end

  describe "DELETE 'destroy' - /admin/countries/xx - " do

    before(:each) do
      @country = mock_model(Country, :id => 1, :to_param => "1", :name => "Name")
      @country.stub!(:destroy).and_return(true)
      Country.stub!(:find).with("1").and_return(@country)
    end

    def do_delete
      delete :destroy, :id => "1"
    end

    describe "with a valid country and successful deletion" do

      it "should get the country" do
        Country.should_receive(:find).with("1").and_return(@country)
        do_delete
      end
      it "should destroy the object" do
        @country.should_receive(:destroy).and_return(true)
        do_delete
      end
      it "should set the flash notice" do
        do_delete
        flash[:notice].should == "Country destroyed"
      end
      it "should redirect to the country index" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_countries_path)
      end
      
    end

    describe "with a valid country and no deletion" do
      before(:each) do
        @country.stub!(:destroy).and_return(false)
      end

      it "should not destroy the object" do
        @country.should_receive(:destroy).and_return(false)
        do_delete
      end
      it "should set the flash error" do
        do_delete
        flash[:error].should == "Could not destroy #{@country.name}"
      end
      it "should redirect to the country index" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_countries_path)
      end
      
    end

    describe "with invalid country" do

      before(:each) do
        Country.stub!(:find).with("1").and_return(nil)
      end

      it "should not get the country" do
        Country.should_receive(:find).with("1").and_return(nil)
        do_delete
      end
      it "should redirect to index" do
        do_delete
        response.should be_redirect
        response.should redirect_to(admin_countries_path)
      end
    end

  end

  # describe "GET 'show' - /admin/countries/xx - " do
  # 
  #   before(:each) do
  #     @country = mock_model(Country, :id => 1, :to_param => 1, :name => "CountryName")
  #     Country.stub!(:find).with("1").and_return(@country)
  #   end
  # 
  #   def do_get
  #     get :show, :id => 1
  #   end
  # 
  #   describe "with a valid country" do
  # 
  #     it "should get the country" do
  #       Country.should_receive(:find).with("1").and_return(@country)
  #       do_get
  #     end
  #     it "should assign found order to @order for the view" do
  #       do_get
  #       assigns[:country].should == @country
  #     end
  #     it "should find products in country"
  #     it "should assign products to @product for the view"
  #   end
  # 
  #   describe "with invalid country" do
  # 
  #     before(:each) do
  #       Country.stub!(:find).with("1").and_return(nil)
  #     end
  # 
  #     it "should not get the country" do
  #       Country.should_receive(:find).with("1").and_return(nil)
  #       do_get
  #     end
  #     it "should redirect to index" do
  #       do_get
  #       response.should be_redirect
  #       response.should redirect_to(admin_countries_path)
  #     end
  #   end
  # 
  # 
  # end

end
