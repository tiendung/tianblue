require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/articles" do
  before(:each) do
    @articles = [
      mock_model(Article, :id => 1, :to_param => 1, :title => "Article1", :posted_at => Time.now-1.day),
      mock_model(Article, :id => 2, :to_param => 2, :title => "Article2", :posted_at => Time.now-2.day)
    ]

    assigns[:articles] = @articles
    assigns[:page_title] = "Articles"
    
    render 'admin/articles/index'
  end
  Article
  it "should display page title products" do
    response.should have_tag('h1', "Articles")
  end
  it "should show each article in a tabular format" do
    response.should have_tag('table tbody tr', 2)
  end
  it "should show links to the order pages" do
    response.should have_tag('tbody th', (Time.now-1.day).strftime("%d %b, %y"))
    response.should have_tag('tbody tr+tr th', (Time.now-2.day).strftime("%d %b, %y"))
  end
  it "should show links to the order pages" do
    response.should have_tag('tbody td', /Article1/)
    response.should have_tag('tbody tr+tr td', /Article2/)
  end
  it "should show links to edit the order pages" do
    response.should have_tag('tbody td a[href=?]', edit_admin_article_path(1))
    response.should have_tag('tbody tr+tr td a[href=?]', edit_admin_article_path(2))
  end
  
  it "should link to new form" do
    response.should have_tag("a[href=?]", new_admin_article_path)
  end
      
end