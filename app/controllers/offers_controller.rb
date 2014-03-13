class OffersController < ApplicationController
 def index
    @user = User.find(params[:user_id])
    @user.received_offers.size != 0 ? @offers = @user.received_offers : @offers = nil
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
    @user2 = User.last
    @offer = Offer.new

    respond_to do |format|
      format.html # new.html.erb
      format.js # render new.js.erb
    end
  end

  def edit
    # @user = User.find(params[:user_id])
    @user = User.first
    @user2 = User.last
    @offer = Offer.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
      format.js # render edit.js.erb
    end
  end

  def create
    @user_composer = User.find(params[:user_id])
    @user_receiver = User.find(params[:offer][:user_receiver_id])

    @offer = Offer.new(message:params[:offer][:message], user_composer:@user_composer, user_receiver:@user_receiver, user_sheets: [@user_composer.sheet, @user_receiver.sheet])
    @proposal = Proposal.new(composer_id:@user_composer.id, receiver_id:@user_receiver.id)

    params[:offer][:goods].each do |good_params|
      if (good_params[:type] == 'Product')
        puts good_params[:item_id]
        #TODO: reducir la búsqueda a los items del composer y del receiver
        @item = Item.find(good_params[:item_id])
        puts @item.id
        @good = Product.new(name:@item.name, description:@item.description, owner_id:@item.user.id, images:@item.images)
        @good.id = @item.id
        puts @good.id
      else
        @good = Cash.new(owner_id:good_params[:owner_id], amount:good_params[:amount])
      end
      @proposal.goods << @good
    end

    @offer.proposal = @proposal




  puts "*******************************************************************************"
    puts @offer.valid?
    puts @offer.proposal.goods.first.id
    puts @offer.proposal.goods.last.id
    puts @offer.proposal.errors.messages
    puts "*******************************************************************************"  #TODO: REVISAR SERGIO
    respond_to do |format|
      if @offer.save
        format.html { redirect_to @user, notice: 'Offer has been successfully created.' }
        format.js { render 'add_offer_in_list', :layout => false, :locals => { :offer => @offer }, :status => :created }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @offer = Offer.find(params[:id])

    @offer.message = params[:offer][:message]
    @offer.proposal.goods.all.delete

    params[:offer][:goods].each do |good_params|
      if (good_params[:type] == 'Product')
        #TODO: reducir la búsqueda a los items del composer y del receiver
        @item = Item.find(good_params[:item_id])
        @good = Product.new(_id:@item.id, name:@item.name, description:@item.description, owner_id:@item.user.id, images:@item.images)
      else
        @good = Cash.new(owner_id:good_params[:owner_id], amount:good_params[:amount])
      end
      @offer.proposal.goods << @good
    end

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @offer.save
        format.html { redirect_to @user, notice: 'Offer has been successfully updated.' }
        format.js { render 'reload_offer_list', :layout => false}
      else
        format.html { redirect_to @offer, notice: 'Offer has not been updated.'}
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
end
