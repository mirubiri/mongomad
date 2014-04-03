class OffersController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user.received_offers.size != 0 ? @offers = @user.received_offers.desc(:updated_at) : @offers = nil
    @negotiation = Negotiation.new

    respond_to do |format|
      format.html # index.html.erb
      format.js # render index.js.erb
    end
  end

  def show
    @offer = Offer.find(params[:id])
    @negotiation = Negotiation.new

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @user = User.find(params[:user_id])
    @offer = Offer.new

    respond_to do |format|
      format.html # new.html.erb
      format.js # render new.js.erb
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @offer = Offer.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
      format.js # render edit.js.erb
    end
  end

  def create
    @user = User.find(params[:user_id])
    @negotiation = Negotiation.new

    @offer = Offer.new(message:params[:offer][:message], user_composer:current_user, user_receiver:@user, user_sheets: [current_user.sheet, @user.sheet])
    @offer.proposal = Proposal.new(composer_id:current_user.id, receiver_id:@user.id)
    update_offer(@offer, params[:offer])

    respond_to do |format|
      if @offer.save
        @offers = @user.received_offers
        format.html { redirect_to @user, notice: 'Offer has been successfully created.' }
        format.js { render 'add_offer_in_list', :layout => false, :locals => { :offer => @offer }, :status => :created }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @user = User.find(params[:user_id])
    @negotiation = Negotiation.new
    @offer = current_user.sent_offers.find(params[:id])

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if update_offer(@offer, params[:offer])
        @offers = @user.received_offers.desc(:updated_at)
        format.html { redirect_to @user, notice: 'Offer has been successfully updated.' }
        format.js { render 'reload_offer_list', :layout => false }
      else
        format.html { redirect_to user_offers_url, notice: 'Offer has not been updated.' }
      end
    end
  end

  def destroy
    @offer = Offer.find(params[:id])
    @offer.hide

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @offer.save
        format.html { redirect_to user_offers_url, notice: 'Offer has been successfully deleted.' }
      else
        # ni idea :)
      end
    end
  end

  private
  def update_offer(offer, params)
    products = get_products_from_items(params[:products])
    message = params[:message]
    cash = parse_cash(params[:cash]) if params[:cash]

    goods = []
    goods << products
    goods << cash

    offer.message = message
    offer.proposal.goods = nil
    offer.proposal.goods << goods
    offer
  end
end
