require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/articles/new" do
  before(:each) do
    @article = mock_model(Article, :title=>nil, :body=>nil, :summary=>nil, :posted_at=>nil)

    # need to stub error object for my proper form ?

    assigns[:article] = @article
    assigns[:page_title] = "New Article"
    
    render 'admin/articles/new'
  end
  
  it "should display page title articles" do
    response.should have_tag('h1', "New Article")
  end
  
  it "should PUT to the article path" do
    response.should have_tag('form[action=?][method=?]', admin_articles_path, :post)
  end
  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li input[type=?][name=?]', "text", "article[title]")
      with_tag('li textarea[name=?]', "article[summary]")
      with_tag('li textarea[name=?]', "article[body]")
      with_tag('li select[name=?]', "article[posted_at(1i)]")
    end
  end
  it "should display submit button" do
    response.should have_tag('form fieldset.submit') do
      with_tag('input[value=?]', "Create")
    end
  end

  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_articles_path, "back to articles list")
    end
  end

end