class PromotionsController < ApplicationController
  
  layout "admin"
  before_filter :admin_required, :except => :show
  
  # GET /promotions
  # GET /promotions.xml
  def index
    @promotions = Promotion.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @promotions }
    end
  end

  # GET /promotions/1
  # GET /promotions/1.xml
  def show
    bind_signup_to_promotion(params[:id])
    
    redirect_to new_user_path
    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.xml  { render :xml => @promotion }
    # end
  end

  # GET /promotions/new
  # GET /promotions/new.xml
  def new
    @promotion = Promotion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @promotion }
    end
  end

  # GET /promotions/1/edit
  def edit
    @promotion = Promotion.find(params[:id])
  end

  # POST /promotions
  # POST /promotions.xml
  def create
    @promotion = Promotion.new(params[:promotion])

    respond_to do |format|
      if @promotion.save
        flash[:notice] = 'Promotion was successfully created.'
        format.html { redirect_to(promotions_url) }
        format.xml  { render :xml => @promotion, :status => :created, :location => @promotion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @promotion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /promotions/1
  # PUT /promotions/1.xml
  def update
    @promotion = Promotion.find(params[:id])

    respond_to do |format|
      if @promotion.update_attributes(params[:promotion])
        flash[:notice] = 'Promotion was successfully updated.'
        format.html { redirect_to(promotions_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @promotion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /promotions/1
  # DELETE /promotions/1.xml
  def destroy
    @promotion = Promotion.find(params[:id])
    @promotion.destroy

    respond_to do |format|
      format.html { redirect_to(promotions_url) }
      format.xml  { head :ok }
    end
  end
end
