class PagesController < ApplicationController

  def show
    if @page = Page.find_by_permalink(params[:id])
      @page_title = @page.name
      @image = @page.image
    else
      render :file => RAILS_ROOT+"/public/404.html", :status => 404
    end
  end

end
