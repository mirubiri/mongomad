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

    # @user_composer = User.find(params[:user_id])
    # @user_receiver = User.find(params[:offer][:user_receiver_id])

    @offer = Offer.new(message:params[:offer][:message], user_composer:current_user, user_receiver:@user, user_sheets: [current_user.sheet, @user.sheet])
    @proposal = Proposal.new(composer_id:current_user.id, receiver_id:@user.id)

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
    @offers = @user.received_offers

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
    @user = User.find(params[:user_id])
    @offer = Offer.find(params[:id])
    @negotiation = Negotiation.new

    @offer.message = params[:offer][:message]
    puts "*******************************************************************************"
    puts @offer.proposal.goods.size
        @offer.proposal.goods.delete_all
    puts @offer.proposal.goods.size
    puts "*******************************************************************************"

    params[:offer][:goods].each do |good_params|
      if (good_params[:type] == 'Product')
        #TODO: reducir la búsqueda a los items del composer y del receiver
        @item = Item.find(good_params[:item_id])
puts "*******************************************************************************"
puts@item.user_id
puts@offer.proposal.composer_id
puts@offer.proposal.receiver_id
        @good = Product.new(name:@item.name, description:@item.description, owner_id:@item.user_id, images:@item.images)
        @good.id = @item.id
        # @good = Product.new(_id:@item.id, name:@item.name, description:@item.description, owner_id:@item.user.id, images:@item.images)
      else
        @good = Cash.new(owner_id:good_params[:owner_id], amount:good_params[:amount])
      end
      @offer.proposal.goods << @good
puts @offer.proposal.goods.size
#     @offer.proposal.goods.delete_all
# puts @offer.proposal.goods.size
puts @offer.valid?
puts @offer.proposal.errors.messages
puts "*******************************************************************************"

    end

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @offer.save
        @offers = @user.received_offers.desc(:updated_at)
        format.html { redirect_to @user, notice: 'Offer has been successfully updated.' }
        format.js { render 'reload_offer_list', :layout => false}
      else
        format.html { redirect_to user_offers_url, notice: 'Offer has not been updated.'}
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
