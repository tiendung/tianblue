class Admin::ArticleImagesController < ApplicationController

  layout "admin"

  before_filter :get_article
  before_filter :admin_required

  def new
    @image = ArticleImage.new
    @page_title = "New Image for #{@article.title}"
  end

  def create
    @image = ArticleImage.new(params[:image])
    if @article.images << @image
      flash[:notice] = 'Image created successfully'
      redirect_to edit_admin_article_path(@article)     
    else
      flash[:error] = 'Could not create image'
      redirect_to new_admin_article_image_path(@article)     
    end
  end

  def destroy
    @image = ArticleImage.find(params[:id])
    if @image.destroy
      flash[:notice] = "Image Deleted"
    else
      flash[:error] = "Could not delete image"
    end
    redirect_to edit_admin_article_path(@article)
  end

  private
  
  def get_article
    @article = Article.find_by_permalink(params[:article_id])
  end

end
