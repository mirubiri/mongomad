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
    @proposal = Proposal.new(composer_id:current_user.id, receiver_id:@user.id)
    @offer.proposal = fill_proposal_goods(@proposal, params)

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
    # @offer = Offer.find(params[:id])
    @offer.message = params[:offer][:message]
    @offer.proposal.goods.delete_all

    fill_proposal_goods(@offer.proposal, params)

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @offer.save
        @offers = @user.received_offers.desc(:updated_at)
        format.html { redirect_to @user, notice: 'Offer has been successfully updated.' }
        format.js { render 'reload_offer_list', :layout => false}
      else
        format.html { redirect_to user_offers_url, notice: 'Offer has not been updated.' }
      end
    end
  end

  def destroy
    @offer = Offer.find(params[:id])

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @offer.destroy
        format.html { redirect_to user_offers_url, notice: 'Offer has been successfully deleted.' }
      else
        # ni idea :)
      end
    end
  end

  private
  def fill_proposal_goods (proposal, params)
    if (params[:offer][:cash] != nil)
      image = Attachment::Image.new(main:true)
      image.id = 'static/images/money'
      good = Cash.new(owner_id:params[:offer][:cash][:owner_id])
      good.money = Money.new(params[:offer][:cash][:amount])
      good.images << image
      proposal.goods << good
    end

    if (params[:offer][:products]!=nil)
      params[:offer][:products].each do |product_params|
        #TODO: Reducir la búsqueda a los items del composer y del receiver
        item = Item.find(product_params[:item_id])
        good = Product.new(name:item.name, description:item.description, owner_id:item.user.id, images:item.images)
        good.id = item.id
        proposal.goods << good
      end
    end
    proposal
  end
end
