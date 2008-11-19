require File.dirname(__FILE__) + '/../spec_helper'

describe PagesController do

  describe "GET 'show' - /xx - " do
  
    before(:each) do
      @image = mock_model(PageImage)
      @page = mock_model(Page, :id => 1, :to_param => 1, :name => "PageName", :image => @image)
      Page.stub!(:find_by_permalink).with("name").and_return(@page)
    end
  
    def do_get
      get :show, :id => "name"
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
      it "should assign found page to @page for the view" do
        do_get
        assigns[:image].should == @page.image
      end
      it "should set a page title for the view" do
        do_get
        assigns[:page_title].should == @page.name
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
    end

  end

end
