# hash_offer
#   id o offer_id (para el editar / borrar)
#   user_id
    # offer
    #   goods
    #     [ type: cash/Product,
    #       _id: id del product/item
    #       quantity: en el caso de ser cash
    #     ]
#     initial_message : valor

class OffersController < ApplicationController
 def index
    @user = User.find(params[:user_id])
    @user.received_offers.count == 0 ? @offers = nil : @offers = @user.received_offers
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
    @user = User.find(params[:user_id])
    @offer = Offer.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /offers
  # POST /offers.json
  def create
  #TODO: revisar
    @user = Fabricate(:user_with_items)
    @user_receiver = User.find(params[:offer][:user_receiver_id])
    @offer = Fabricate.build(:offer, user_composer:@user, user_receiver:@user_receiver)
    puts "*******************************"
    puts @offer.valid?
    puts "*******************************"

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @user, notice: 'Offer was successfully created.' }
        format.js { render 'add_offer_in_list', :layout => false, :locals => { :offer => @offer }, :status => :created }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /offers/1
  # PUT /offers/1.json
  def update
    @user = User.find(params[:offer][:user_receiver_id])
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes params[:offer]
        format.html { redirect_to @user, notice: 'Offer was successfully updated.' }
        format.js { render 'reload_offer_list', :layout => false}
      else
        format.html { redirect_to @offer, notice: 'Offer wasnt updated.'}
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
    end
  end
end
