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
    @offer = link_offer_to_negotiation(@offer, @negotiation)

    # link_offer_to_negotiation(@offer, @negotiation)
    # puts "*******************************************************************************"
    # puts @offer.proposal.valid?
    # puts @offer.proposal.errors.messages
    # puts @negotiation.valid?
    # puts @negotiation.errors.messages
    # puts "*******************************************************************************"

    respond_to do |format|
      if save_negotiation_and_offer(@negotiation, @offer)
        @negotiations = current_user.negotiations
        format.html { redirect_to user_negotiations_path, notice: 'Negotiation was successfully created.' }
        format.js { render 'add_negotiation_in_list', :layout => false, :locals => { :negotiation => @negotiation }, :status => :created }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @negotiation = current_user.negotiations.find(params[:id])
    @proposal = generate_proposal_from_params(params[:offer])
    # disable_last_proposal(@negotiation)
    add_proposal_to_negotiation(@proposal, @negotiation)

    # puts "*******************************************************************************"
    # puts @proposal.valid?
    # puts @proposal.errors.messages
    # puts @negotiation.valid?
    # puts @negotiation.errors.messages
    # puts "*******************************************************************************"

    # recuperar la negociacion
    # generar una nueva propuesta
    # añadir la propuesta a la negociacion
    # salvar la negociacion

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @negotiation.save
        # puts "*******************************************************************************"
        # puts "hemos llegado me cawen la puta!"
        # puts "*******************************************************************************"
        @negotiations = current_user.negotiations.desc(:updated_at)
        format.html { redirect_to current_user, notice: 'Negotiation was successfully updated.' }
        format.js { render 'reload_negotiations', :layout => false }
      else
        # puts "ni pa dios!"
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
    @negotiation.messages << Message.new(user_id:current_user.id, text:params[:message])

    Pusher.trigger('my_negotiations_channel', 'my_event', { message: params[:message], negotiation_id: params[:negotiation_id], sender_image_tag: params[:sender_image_tag] })
    Pusher.trigger('my_negotiations_channel', 'my_notification', { message: params[:message], negotiation_id: params[:negotiation_id], sender_image_tag: params[:sender_image_tag] })

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
    # negotiation.proposals << offer.proposal

    negotiation
  end

  def link_offer_to_negotiation(offer, negotiation)
    # puts "*******************************************************************************"
    # puts negotiation.valid?
    # puts negotiation.errors
    # puts offer.valid?
    # puts offer.errors
    # puts "*******************************************************************************"

    offer.negotiation = negotiation
    offer.negotiating = true
    offer.negotiated_times += 1

    # puts "*******************************************************************************"
    # puts negotiation.valid?
    # puts negotiation.errors
    # puts offer.valid?
    # puts offer.errors
    # ap offer
    # puts "*******************************************************************************"
    offer
    # offer.valid? && negotiation.valid?
  end

  def save_negotiation_and_offer(negotiation, offer)
    if offer.valid? && negotiation.valid?
      # puts "*******************************************************************************"
      # puts "llegamos a salvar las cosas"
      # puts "*******************************************************************************"
      offer.save
      # puts "salvamos offer"
      negotiation.save
      # puts "salvamos negotiation"
    else
      false
    end
  end

  def generate_proposal_from_params(params)
    proposal = Proposal.new(composer_id:current_user.id, receiver_id:guess_receiver.id)

    products = get_products_from_items(params[:products])
    cash = parse_cash(params[:cash]) if params[:cash]

    goods = []
    goods << products
    goods << cash

    proposal.goods = nil
    proposal.goods << goods
    proposal
  end

  # TODO: eliminar y usar las del controlador de offer
  def get_products_from_items(item_ids)
    item_ids.map { |id| Item.find(id[:item_id]).to_product }
  end

  # TODO: eliminar y usar las del controlador de offer
  def parse_cash(cash_params)
    cash = Cash.new(owner_id:cash_params[:owner_id])
    cash.money = Money.new(cash_params[:amount])
    cash.images << Attachment::Image.new(main:true) do |image|
      image.id = 'static/images/money'
    end
    cash
  end

  def add_proposal_to_negotiation(proposal, negotiation)
    disable_last_proposal(negotiation)
    negotiation.proposals << proposal
    negotiation
  end

  def disable_last_proposal(negotiation)
    negotiation.proposals.last.actionable = false
    negotiation
  end
end
