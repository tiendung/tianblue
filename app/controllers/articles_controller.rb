class ArticlesController < ApplicationController

  def index
    @articles = Article.current
    @page_title = "Latest News"
  end

  def show
    @article = Article.find_by_permalink(params[:id])
    if @article
      @images = @article.images
      @page_title = @article.title
    else
      redirect_to root_url
    end
  end

end
