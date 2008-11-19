class Admin::CountriesController < ApplicationController
  
  layout "admin"
  before_filter :admin_required
  
  def index
    @countries = Country.all
    @page_title = "Countries"
  end
  
  # def show
  #   unless @country = Country.find(params[:id])
  #     redirect_to admin_countries_path
  #   end
  # end
  
  def new
    @country = Country.new
    @page_title = "New Country"
  end

  def create
    @country = Country.new(params[:country])
    if @country.save
      flash[:notice] = "Country created"
      redirect_to admin_countries_path
    else
      flash[:error] = "Could not create country"
      render :action => "new"
    end
  end

  def edit
    if @country = Country.find(params[:id])
      @page_title = "Edit " + @country.name
    else
      redirect_to admin_countries_path
    end
  end

  def update
    if @country = Country.find(params[:id])
      if @country.update_attributes(params[:country])
        flash[:notice] = "Country updated"
        redirect_to admin_countries_path
      else
        flash[:error] = "Could not update country"
        render :action => "edit"
      end
    else
      redirect_to admin_countries_path 
    end
  end

  def destroy
    if @country = Country.find(params[:id])
      if @country.destroy
        flash[:notice] = "Country destroyed"
      else
        flash[:error] = "Could not destroy #{@country.name}"
      end
    end
    redirect_to admin_countries_path 
  end

  
end
