class OffersController < ApplicationController

  def index
    @data.offers = Offer.all

    respond_to do |format|
      format.html
      #format.json { render json: @data.offers }
    end
  end

  def new
    @data.offer = Offer.new
    @data.current_user = current_user
    @data.visited_user_items = Item.where(user_id:@data.visited_user.id)
    @data.current_user_items = Item.where(user_id:@data.current_user.id)

    respond_to do |format|
      format.html { render :template => "proposal/new" }
      #format.json { render json: @data.offer }
    end
  end

  def edit
    @data.offer = Offer.find(params[:id])
    @data.current_user = current_user
    @data.visited_user_items = Item.where(user_id:@data.visited_user.id)
    @data.current_user_items = Item.where(user_id:@data.current_user.id)
  end

  def create
    offer = Offer.new(params[:offer])

    respond_to do |format|
      if offer.save
        format.html { redirect_to offer, notice: 'Offer was successfully created.' }
        #format.json { render json: @data.offer, status: :created, location: @data.offer }
      else
        format.html { render action: "new" }
        #format.json { render json: @data.offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    offer = Offer.find(params[:id])

    respond_to do |format|
      if offer.update_attributes(params[:offer])
        format.html { redirect_to @data.offer, notice: 'Offer was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @data.offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    offer = Offer.find(params[:id])
    offer.destroy

    respond_to do |format|
      format.html { redirect_to offers_url }
      #format.json { head :no_content }
    end
  end
end
