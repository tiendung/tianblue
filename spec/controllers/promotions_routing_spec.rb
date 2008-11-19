require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PromotionsController do
  describe "route generation" do

    it "should map { :controller => 'promotions', :action => 'index' } to /promotions" do
      route_for(:controller => "promotions", :action => "index").should == "/promotions"
    end
  
    it "should map { :controller => 'promotions', :action => 'new' } to /promotions/new" do
      route_for(:controller => "promotions", :action => "new").should == "/promotions/new"
    end
  
    it "should map { :controller => 'promotions', :action => 'show', :id => 1 } to /promotions/1" do
      route_for(:controller => "promotions", :action => "show", :id => 1).should == "/promotions/1"
    end
  
    it "should map { :controller => 'promotions', :action => 'edit', :id => 1 } to /promotions/1/edit" do
      route_for(:controller => "promotions", :action => "edit", :id => 1).should == "/promotions/1/edit"
    end
  
    it "should map { :controller => 'promotions', :action => 'update', :id => 1} to /promotions/1" do
      route_for(:controller => "promotions", :action => "update", :id => 1).should == "/promotions/1"
    end
  
    it "should map { :controller => 'promotions', :action => 'destroy', :id => 1} to /promotions/1" do
      route_for(:controller => "promotions", :action => "destroy", :id => 1).should == "/promotions/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'promotions', action => 'index' } from GET /promotions" do
      params_from(:get, "/promotions").should == {:controller => "promotions", :action => "index"}
    end
  
    it "should generate params { :controller => 'promotions', action => 'new' } from GET /promotions/new" do
      params_from(:get, "/promotions/new").should == {:controller => "promotions", :action => "new"}
    end
  
    it "should generate params { :controller => 'promotions', action => 'create' } from POST /promotions" do
      params_from(:post, "/promotions").should == {:controller => "promotions", :action => "create"}
    end
  
    it "should generate params { :controller => 'promotions', action => 'show', id => '1' } from GET /promotions/1" do
      params_from(:get, "/promotions/1").should == {:controller => "promotions", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'promotions', action => 'edit', id => '1' } from GET /promotions/1;edit" do
      params_from(:get, "/promotions/1/edit").should == {:controller => "promotions", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'promotions', action => 'update', id => '1' } from PUT /promotions/1" do
      params_from(:put, "/promotions/1").should == {:controller => "promotions", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'promotions', action => 'destroy', id => '1' } from DELETE /promotions/1" do
      params_from(:delete, "/promotions/1").should == {:controller => "promotions", :action => "destroy", :id => "1"}
    end
  end
end
