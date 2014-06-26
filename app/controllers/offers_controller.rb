class OffersController < ApplicationController

  def index
    @offers = Offer.all
    # @requests = Request.where(user_id:current_user.id)
    @requests = Request.all

    respond_to do |format|
      format.html
      #format.json { render json: @offers }
    end
  end

  def new
    @offer = Offer.new
    # @items = Item.where(user_id:current_user.id)
    # @requests = Request.where(user_id:current_user.id)
    @items = Item.all
    @requests = Request.all

    respond_to do |format|
      format.html { render :template => "proposal/new" }
      #format.json { render json: @offer }
    end
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def create
    @offer = Offer.new(params[:offer])

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
        #format.json { render json: @offer, status: :created, location: @offer }
      else
        format.html { render action: "new" }
        #format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy

    respond_to do |format|
      format.html { redirect_to offers_url }
      #format.json { head :no_content }
    end
  end
end
