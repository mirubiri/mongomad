class NegotiationsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user.negotiations.size != 0 ? @negotiations = @user.negotiations.desc(:updated_at) : @negotiations = nil

    respond_to do |format|
      format.html # index.html.erb
      format.js # render index.js.erb
    end
  end

  def show
    @negotiation = Negotiation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @negotiation = Negotiation.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @negotiation = Negotiation.find(params[:id])
    @user = guess_receiver

    respond_to do |format|
      format.html # edit.html.erb
      format.js # render edit.js.erb }
    end
  end

  def create
    # @user = User.find(params[:user_id])
    # @offer = Offer.find(params[:offer_id])
    # @negotiations = @user.negotiations
    # @negotiation = Fabricate.build(:negotiation, offer:@offer)

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @negotiation.save
        format.html { redirect_to user_negotiations_path, notice: 'Negotiation was successfully created.' }
        format.js {render 'add_negotiation_in_list', :layout => false, :locals => { :negotiation => @negotiation }, :status => :created}
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @negotiation = current_user.negotiations.find(params[:id])
    @user = guess_receiver
    @proposal = Proposal.new(composer_id:current_user.id, receiver_id:@user.id)
    @negotiation.proposals << fill_proposal_goods(@proposal, params)

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @negotiation.save
        @negotiations = current_user.negotiations.desc(:updated_at)
        format.html { redirect_to current_user, notice: 'Negotiation was successfully updated.' }
        format.js { render 'reload_negotiations', :layout => false }
      else
        #ni idea
      end
    end
  end

  def destroy
    @negotiation = Negotiation.find(params[:id])
    @negotiation.destroy

    #TODO: REVISAR SERGIO
    respond_to do |format|
      format.html { redirect_to user_negotiations_url }
    end
  end

  #TODO: REVISAR
  def sign
    @negotiation = Negotiation.find(params[:id])
    proposal(@negotiation).sign_receiver

    respond_to do |format|
      format.js { render :partial => "negotiations/reload_negotiations_list" }
    end
  end

  #TODO: REVISAR
  def confirm
    @negotiation = Negotiation.find(params[:id])

    respond_to do |format|
      if proposal(@negotiation).sign_receiver
        format.js { render :partial => "negotiations/reload_negotiations_list" }
      else
        format.js { render :partial => "negotiations/reload_negotiations_list" }
      end
    end
  end

  #TODO: REVISAR
  def cancel
    @user = User.find(params[:user_id])
    @negotiation = Negotiation.find(params[:id])

    id(composer(proposal(@negotiation))) == id(@user) ? proposal(@negotiation).cancel_composer : proposal(@negotiation).cancel_receiver

    respond_to do |format|
      format.js { render :partial => "negotiations/reload_negotiations_list" }
    end
  end

  def pusher_message
    @user = User.find(params[:user_id])
    Pusher.trigger('my_negotiations_channel', 'my_event', {message: params[:message], negotiation_id: params[:negotiation_id], sender_image_tag: params[:sender_image_tag] })
    Pusher.trigger('my_negotiations_channel', 'my_notification', {message: params[:message], negotiation_id: params[:negotiation_id], sender_image_tag: params[:sender_image_tag] })
    respond_to do |format|
      format.js
    end
  end

  private
  def guess_receiver
    current_user.id == @negotiation.proposal.composer_id ? receiver_id = @negotiation.proposal.receiver_id : receiver_id = @negotiation.proposal.composer_id
    User.find(receiver_id)
  end

  def fill_proposal_goods (proposal, params)
    #TODO: CAMBIAR EL NOMBRE AL HASH DE OFFER A PROPOSAL
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
