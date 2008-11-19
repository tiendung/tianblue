class Admin::ArticlesController < ApplicationController

  layout "admin"
  before_filter :admin_required

  def index
    @articles = Article.all
    @page_title = "Articles"
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      flash[:notice] = "Article created"
      redirect_to admin_articles_path
    else
      flash[:error] = "Could not create article"
      render :action => "new"
    end
  end

  def edit
    if @article = Article.find_by_permalink(params[:id])
      @page_title = "Edit Article"
      @images = @article.images
    else
      redirect_to admin_articles_path
    end
  end

  def update
    if @article = Article.find_by_permalink(params[:id])
      if @article.update_attributes(params[:article])
        flash[:notice] = "Article updated"
        redirect_to admin_articles_path
      else
        flash[:error] = "Could not update article"
        render :action => "edit"
      end
    else
      redirect_to admin_articles_path 
    end
  end

  def destroy
    if @article = Article.find_by_permalink(params[:id])
      if @article.destroy
        flash[:notice] = "Article destroyed"
      else
        flash[:error] = "Could not destroy article"
      end
    else
      flash[:error]= "Could not find article to destroy"
    end
    redirect_to admin_articles_path
  end

end
