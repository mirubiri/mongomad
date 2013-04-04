class OffersController < ApplicationController

  def sub_layout
    "offers"
  end

  def index
    @user = User.find(params[:user_id])
    @offers = @user.received_offers.all.to_a
    @requests = @user.requests.all.to_a
    @offer = Offer.new
    @negotiation = Negotiation.new

    respond_to do |format|
      format.html # index.html.erb
      format.js # render index.js.erb
    end
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
    @offer = Offer.find(params[:id])
    @negotiation = Negotiation.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @offer }
    end
  end

  # GET /offers/new
  # GET /offers/new.json
  def new
    @offer = Offer.new
    @user = User.find(params[:user_id])

    respond_to do |format|
      format.html # new.html.erb
      format.js # render new.js.erb
    end
  end

  # GET /offers/1/edit
  def edit
    @offer = Offer.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end

  end

  # POST /offers
  # POST /offers.json
  def create
    @user = current_user
    @offer = Offer.new(params[:offer])
    @offer.user_composer = @user

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @user, notice: 'Offer was successfully created.' }
        format.js { render :partial => "offers/reload_offers_list", :layout => false, :locals => { :offer => @offer }, :status => :created }
      else
        format.html { render action: "new" }
        format.json { render json: @offer.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PUT /offers/1
  # PUT /offers/1.json
  def update
    @user = current_user
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.js { render :partial => "offers/edit_offer_in_list", :layout => false  }
      else
        format.html { render action: "edit" }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy

    respond_to do |format|
      format.html { redirect_to user_offers_url }
      format.json { head :no_content }
    end
  end
end
