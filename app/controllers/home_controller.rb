class HomeController < ApplicationController
  before_filter :clear_promotion_signup
  before_filter :get_cart

  def index
    if page = Page.find_by_permalink("home")
      @welcome_message = page.html_body
      @image =  page.image
    else
      @welcome_message = "<h1>Testing</h1>"
    end
    @categories = Category.featured
    @top_news = Article.top
  end

end
