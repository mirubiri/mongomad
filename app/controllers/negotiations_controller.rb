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
    @offer = Offer.find(params[:offer_id])
    @negotiation = generate_negotiation_from_offer(@offer)

    respond_to do |format|
      if save_negotiation_and_offer(@negotiation, @offer)
        format.html { redirect_to user_negotiations_path, notice: 'Negotiation was successfully created.' }
        format.js { render 'add_negotiation_in_list', :layout => false, :locals => { :negotiation => @negotiation }, :status => :created }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    # recuperar la negociacion
    # generar una nueva propuesta
    # añadir la propuesta a la negociacion
    # salvar la negociacion


    # @negotiation = current_user.negotiations.find(params[:id])
    # @user = guess_receiver
    # @proposal = Proposal.new(composer_id:current_user.id, receiver_id:@user.id)
    # @negotiation.proposals << fill_proposal_goods(@proposal, params)

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

  # def destroy
  #   @negotiation = Negotiation.find(params[:id])
  #   @negotiation.destroy

  #   #TODO: REVISAR SERGIO
  #   respond_to do |format|
  #     format.html { redirect_to user_negotiations_url }
  #   end
  # end

  # #TODO: REVISAR
  # def sign
  #   @negotiation = Negotiation.find(params[:id])
  #   proposal(@negotiation).sign_receiver

  #   respond_to do |format|
  #     format.js { render :partial => "negotiations/reload_negotiations_list" }
  #   end
  # end

  # #TODO: REVISAR
  # def confirm
  #   @negotiation = Negotiation.find(params[:id])

  #   respond_to do |format|
  #     if proposal(@negotiation).sign_receiver
  #       format.js { render :partial => "negotiations/reload_negotiations_list" }
  #     else
  #       format.js { render :partial => "negotiations/reload_negotiations_list" }
  #     end
  #   end
  # end

  # #TODO: REVISAR
  # def cancel
  #   @user = User.find(params[:user_id])
  #   @negotiation = Negotiation.find(params[:id])

  #   id(composer(proposal(@negotiation))) == id(@user) ? proposal(@negotiation).cancel_composer : proposal(@negotiation).cancel_receiver

  #   respond_to do |format|
  #     format.js { render :partial => "negotiations/reload_negotiations_list" }
  #   end
  # end

  def pusher_message
    @user = current_user
    @negotiation = current_user.negotiations.find(params[:negotiation_id])
    @message = Message.new(user_id:current_user.id, text:params[:message])
    @negotiation.messages << @message

    Pusher.trigger('my_negotiations_channel', 'my_event', {message: params[:message], negotiation_id: params[:negotiation_id], sender_image_tag: params[:sender_image_tag] })
    Pusher.trigger('my_negotiations_channel', 'my_notification', {message: params[:message], negotiation_id: params[:negotiation_id], sender_image_tag: params[:sender_image_tag] })

    #TODO: REVISAR SERGIO
    if @negotiation.save
      #@negotiations = current_user.negotiations.desc(:updated_at)
      format.js
    else
      #ni idea
    end
  end

  private
  def guess_receiver
    current_user.id == @negotiation.proposal.composer_id ? receiver_id = @negotiation.proposal.receiver_id : receiver_id = @negotiation.proposal.composer_id
    User.find(receiver_id)
  end

  # def fill_proposal_goods (proposal, params)
  #   #TODO: CAMBIAR EL NOMBRE AL HASH DE OFFER A PROPOSAL
  #   if (params[:offer][:cash] != nil)
  #     image = Attachment::Image.new(main:true)
  #     image.id = 'static/images/money'
  #     good = Cash.new(owner_id:params[:offer][:cash][:owner_id])
  #     good.money = Money.new(params[:offer][:cash][:amount])
  #     good.images << image
  #     proposal.goods << good
  #   end

  #   if (params[:offer][:products]!=nil)
  #     params[:offer][:products].each do |product_params|
  #       #TODO: Reducir la búsqueda a los items del composer y del receiver
  #       item = Item.find(product_params[:item_id])
  #       good = Product.new(name:item.name, description:item.description, owner_id:item.user.id, images:item.images)
  #       good.id = item.id
  #       proposal.goods << good
  #     end
  #   end
  #   proposal
  # end

  def generate_negotiation_from_offer(offer)
    negotiation = Negotiation.new
    negotiation.users << offer.user_composer
    negotiation.users << offer.user_receiver
    negotiation.offer = offer
    negotiation.user_sheets << offer.user_sheets.first
    negotiation.user_sheets << offer.user_sheets.last
    negotiation.proposals << offer.proposal
    negotiation.messages << Message.new(user_id:offer.user_composer_id, text:offer.message)

    # negotiation = Negotiation.new(users:[ offer.user_composer, offer.user_receiver ],
    #   offer:offer,
    #   user_sheets: offer.user_sheets,
    #   proposals: [ offer.proposal ],
    #   messages: [ Message.new(user_id:offer.user_composer_id, text:offer.message) ])
    #   # negotiation.proposals << offer.proposal
    link_offer_to_negotiation(offer, negotiation)
    negotiation
  end

  def link_offer_to_negotiation(offer, negotiation)
    offer.negotiation = negotiation
    offer.negotiating = true
    offer.negotiated_times += 1
    # save_negotiation_and_offer(negotiation,offer)
  end

  def save_negotiation_and_offer(negotiation, offer)
   # offer.save

    # if offer.valid? && negotiation.valid?
    #   offer.save && negotiation.save
    # else
    #   false
    # end
  end
end
