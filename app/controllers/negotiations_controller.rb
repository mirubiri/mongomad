class NegotiationsController < ApplicationController
  def index
    @user = current_user
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
    link_offer_to_negotiation(@offer, @negotiation)

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
    add_proposal_to_negotiation(@proposal, @negotiation)

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

  #TODO: REVISAR
  def discard
    @negotiation = Negotiation.find(params[:id])
    @negotiation.proposal.discard

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @negotiation.save
        format.js { render :partial => "negotiations/reload_negotiations_list" }
      else
        # ni idea :)
      end
    end
  end

  # #TODO: REVISAR
  # def leave
  #   @negotiation = Negotiation.find(params[:id])
  #   @negotiation.proposal.discard

  #   #TODO: REVISAR SERGIO
  #   respond_to do |format|
  #     if @negotiation.save
  #       format.js { render :partial => "negotiations/reload_negotiations_list" }
  #     else
  #       # ni idea :)
  #     end
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
    negotiation.user_sheets = offer.user_sheets.
    negotiation.proposals << offer.proposal
    negotiation.messages << Message.new(user_id:offer.user_composer_id, text:offer.message)
    negotiation
  end

  def link_offer_to_negotiation(offer, negotiation)
    offer.negotiation = negotiation
    offer.negotiating = true
    offer.negotiated_times += 1
    offer
  end

  def save_negotiation_and_offer(negotiation, offer)
    if offer.valid? && negotiation.valid?
      offer.save && negotiation.save
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
