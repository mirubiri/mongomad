class OffersController < ApplicationController
  def index
    respond_to do |format|
      format.html
      #format.json { render json: offers }
    end
  end

  def new
    offer = Offer.new

    respond_to do |format|
      format.html { render :template => "proposal/new", locals:{ offer:offer } }
      #format.json { render json: offer
    end
  end

  def create
    offer = Offer.new(params[:offer])

    respond_to do |format|
      if offer.save
        format.html { redirect_to offers_url, notice: 'Offer was successfully created.' }
        #format.json { render json: offer, status: :created, location: offer }
      else
        format.html { render 'new' }
        #format.json { render json: offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    offer = Offer.find(params[:id])

    respond_to do |format|
      if offer.update_attributes(params[:offer])
        format.html { redirect_to offers_url, notice: 'Offer was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render 'index' }
        #format.json { render json: offer.errors, status: :unprocessable_entity }
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
