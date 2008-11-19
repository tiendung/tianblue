require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/articles/x/images/new" do
  before(:each) do
    Article.stub!(:find).and_return(@article = mock_model(Article, :title=>"Article Title", :to_param => "permalink"))

    # need to stub error object for my proper form
    # @errors = mock_model(Object)
    # @errors.stub!(:on).with(any_args).and_return(nil)
    # @article.stub!(:errors).and_return(@errors)

    assigns[:article] = @article
    assigns[:page_title] = "New Image for #{@article.title}"
    
    render 'admin/article_images/new'
  end
  
  it "should display page title articles" do
    response.should have_tag('h1', "New Image for Article Title")
  end
  
  it "should PUT to the article path" do
    response.should have_tag('form[action=?][method=?]', admin_article_images_path(@article), :post)
  end

  it "should show all the form fields" do
    response.should have_tag('form fieldset ol') do
      with_tag('li label', "Select Image")
      with_tag('li input[type=?][id=?]', "file", "image_uploaded_data")
    end
  end
  
  it "should display submit button" do
    response.should have_tag('form fieldset.buttons') do
      with_tag('input[value=?]', "Create")
    end
  end
      
  it "should have a link back" do
    response.should have_tag('form fieldset.buttons') do
      with_tag('a[href=?]', edit_admin_article_path(@article), "back to edit article")
      with_tag('a[href=?]', admin_articles_path, "back to articles list")

    end
  end

end