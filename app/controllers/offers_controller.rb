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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @offer }
    end
  end

  # GET /offers/new
  # GET /offers/new.json
  def new
    @offer = Offer.new
    @user = current_user
    @user_visited = User.find(params[:user_id])
    @user_logged = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.js # render new.js.erb
    end
  end

  # GET /offers/1/edit
  def edit
    @offer = Offer.find(params[:id])
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.generate(params[:offer])
    @user = User.find(params[:user_id])

    respond_to do |format|
      if @offer.publish
        format.html { redirect_to @user, notice: 'Offer was successfully created.' }
        format.json { render json: @offer, status: :created, location: @offer }
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
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { head :no_content }
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
    @offer.unpublish

    respond_to do |format|
      format.html { redirect_to user_offers_url }
      format.json { head :no_content }
    end
  end
end
