require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PromotionsController do
  describe "responding to GET /promotions" do

    before(:each) do
      Promotion.stub!(:find)
    end
  
    def do_get
      get :index
    end
  
    it "should succeed" do
      do_get
      response.should be_success
    end

    it "should render the 'index' template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all promotions" do
      Promotion.should_receive(:find).with(:all).and_return([@promotion])
      do_get
    end
  
    it "should assign the found promotions for the view" do
      Promotion.should_receive(:find).and_return([promotion = mock_model(Promotion)] )
      do_get
      assigns[:promotions].should == [promotion]
    end
  end

  describe "responding to GET /promotions.xml" do

    before(:each) do
      Promotion.stub!(:find)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should succeed" do
      do_get
      response.should be_success
    end

    it "should find all promotions" do
      Promotion.should_receive(:find).with(:all)
      do_get
    end
  
    it "should render the found promotions as xml" do
      promotions = mock("Array of Promotions")
      Promotion.should_receive(:find).and_return(promotions)
      promotions.should_receive(:to_xml).and_return("generated XML")
      do_get
      response.body.should == "generated XML"
    end
  end

  describe "responding to GET /promotions/1" do

    before(:each) do
      Promotion.stub!(:find)
    end
  
    def do_get(id="1")
      get :show, :id => id
    end

    it "should succeed" do
      do_get
      response.should be_success
    end
  
    it "should render the 'show' template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the promotion requested" do
      Promotion.should_receive(:find).with("37")
      do_get("37")
    end
  
    it "should assign the found promotion for the view" do
      Promotion.should_receive(:find).and_return(promotion = mock_model(Promotion))
      do_get
      assigns[:promotion].should equal(promotion)
    end
  end

  describe "responding to GET /promotions/1.xml" do

    before(:each) do
      Promotion.stub!(:find)
    end
  
    def do_get(id="1")
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => id
    end

    it "should succeed" do
      do_get
      response.should be_success
    end
  
    it "should find the promotion requested" do
      Promotion.should_receive(:find).with("37")
      do_get("37")
    end
  
    it "should render the found promotion as xml" do
      promotion = mock_model(Promotion)
      Promotion.should_receive(:find).and_return(promotion)
      promotion.should_receive(:to_xml).and_return("generated XML")
      do_get
      response.body.should == "generated XML"
    end
  end

  describe "responding to GET /promotions/new" do

    def do_get
      get :new
    end

    it "should succeed" do
      do_get
      response.should be_success
    end
  
    it "should render the 'new' template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new promotion" do
      Promotion.should_receive(:new)
      do_get
    end
  
    it "should not save the new promotion" do
      Promotion.should_receive(:new).and_return(promotion = mock_model(Promotion))
      promotion.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new promotion for the view" do
      Promotion.should_receive(:new).and_return(promotion = mock_model(Promotion))
      do_get
      assigns[:promotion].should equal(promotion)
    end
  end

  describe "responding to GET /promotions/1/edit" do

    before(:each) do
      Promotion.stub!(:find)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should succeed" do
      do_get
      response.should be_success
    end
  
    it "should render the 'edit' template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the promotion requested" do
      Promotion.should_receive(:find)
      do_get
    end
  
    it "should assign the found Promotion for the view" do
      Promotion.should_receive(:find).and_return(promotion = mock_model(Promotion))
      do_get
      assigns[:promotion].should equal(promotion)
    end
  end

  describe "responding to POST /promotions" do

    before(:each) do
      @promotion = mock_model(Promotion, :to_param => "1")
      Promotion.stub!(:new).and_return(@promotion)
    end
    
    describe "with successful save" do
  
      def do_post
        @promotion.should_receive(:save).and_return(true)
        post :create, :promotion => {}
      end
  
      it "should create a new promotion" do
        Promotion.should_receive(:new).with({}).and_return(@promotion)
        do_post
      end

      it "should assign the created promotion for the view" do
        do_post
        assigns(:promotion).should equal(@promotion)
      end

      it "should redirect to the created promotion" do
        do_post
        response.should redirect_to(promotion_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @promotion.should_receive(:save).and_return(false)
        post :create, :promotion => {}
      end
  
      it "should assign the invalid promotion for the view" do
        do_post
        assigns(:promotion).should equal(@promotion)
      end

      it "should re-render the 'new' template" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "responding to PUT /promotions/1" do

    before(:each) do
      @promotion = mock_model(Promotion, :to_param => "1")
      Promotion.stub!(:find).and_return(@promotion)
    end
    
    describe "with successful update" do

      def do_put
        @promotion.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the promotion requested" do
        Promotion.should_receive(:find).with("1").and_return(@promotion)
        do_put
      end

      it "should update the found promotion" do
        do_put
        assigns(:promotion).should equal(@promotion)
      end

      it "should assign the found promotion for the view" do
        do_put
        assigns(:promotion).should equal(@promotion)
      end

      it "should redirect to the promotion" do
        do_put
        response.should redirect_to(promotion_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @promotion.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should assign the found promotion for the view" do
        do_put
        assigns(:promotion).should equal(@promotion)
      end

      it "should re-render the 'edit' template" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "responding to DELETE /promotions/1" do

    before(:each) do
      @promotion = mock_model(Promotion, :destroy => true)
      Promotion.stub!(:find).and_return(@promotion)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the promotion requested" do
      Promotion.should_receive(:find).with("1").and_return(@promotion)
      do_delete
    end
  
    it "should call destroy on the found promotion" do
      @promotion.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the promotions list" do
      do_delete
      response.should redirect_to(promotions_url)
    end
  end
end
