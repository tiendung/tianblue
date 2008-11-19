require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/categories/xx/edit" do
  before(:each) do
    @article = mock_model(Article,
      :id => 1,
      :to_param => "permalink",
      :title=>"Title",
      :summary=>"Summary",
      :body=>"Body",
      :images => [
        @image1 = mock_model( ArticleImage, :to_param => 1),
        @image2 = mock_model( ArticleImage, :to_param => 2)
      ],
      :posted_at => Time.now
    )
    @image1.stub!(:public_filename).with(:thumb).and_return('image1.jpg')
    @image2.stub!(:public_filename).with(:thumb).and_return('image2.jpg')

    # need to stub error object for my proper form ?

    assigns[:article] = @article
    assigns[:images] = @article.images
    assigns[:page_title] = "Edit Article"
    
    render 'admin/articles/edit'
  end
  
  it "should display page title articles" do
    response.should have_tag('h1', "Edit Article")
  end
  it "should PUT to the article path" do
    response.should have_tag('form[action=?][method=?]', admin_article_path(@article), :post) do
      with_tag("input[type=hidden][name=_method][value=?]", "put")
    end
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
      with_tag('input[value=?]', "Update")
    end
  end
  it "should have a link back" do
    response.should have_tag('form fieldset.submit') do
      with_tag('a[href=?]', admin_articles_path, "back to articles list")
    end
  end
  it "should show delete button" do
    content_for(:sub).should have_tag('form[action=?]', admin_article_path(@article)) do
      with_tag("input[type=hidden][name=_method][value=delete]")
      with_tag("input[type=submit]")
    end
  end

  it "should show images" do
    content_for(:sub).should have_tag('ul.images') do
      with_tag('li img[src=?]', "image1.jpg")
      with_tag('li img[src=?]', "image2.jpg")
    end
  end
  it "should show buttons to destroy images" do
    content_for(:sub).should have_tag('ul.images li') do
      with_tag('form[action=?] input[value=?]', admin_article_image_path(@article, @image1), "Delete")
      with_tag('form[action=?] input[value=?]', admin_article_image_path(@article, @image2), "Delete")
      with_tag('input[name=?][type=?][value=?]', "_method", "hidden", "delete", 2)
    end    
  end
  it "should have a link to new images" do
    content_for(:sub).should have_tag('a[href=?]', new_admin_article_image_path(@article), "Add a new image")
  end

end