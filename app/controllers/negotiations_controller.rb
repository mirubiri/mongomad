class NegotiationsController < ApplicationController

  include ApplicationHelper

  #before_filter :authenticate_user!
  # GET /negotiations
  # GET /negotiations.json
  def index
    @user = User.find(params[:user_id])
    @negotiation = Negotiation.new

    respond_to do |format|
      format.html # index.html.erb
      format.js # render index.js.erb
    end
  end

  # GET /negotiations/1
  # GET /negotiations/1.json
  def show
    @negotiation = Negotiation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /negotiations/new
  # GET /negotiations/new.json
  def new
    @negotiation = Negotiation.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /negotiations/1/edit
  def edit
    @negotiation = Negotiation.find(params[:id])
    @user = @negotiation.proposals.last.receiver

    respond_to do |format|
      format.html # edit.html.erb
      format.js # render edit.js.erb }
    end

  end

  # POST /negotiations
  # POST /negotiations.json
  def create
    @user = User.find(params[:user_id])
    @offer = @user.received_offers.find(params[:offer_id])

    respond_to do |format|
      if @negotiation = @offer.negotiate
        format.html { redirect_to user_negotiations_path, notice: 'Negotiation was successfully created.' }
        format.js {render 'add_negotiation_in_list', :layout => false, :locals => { :negotiation => @negotiation }, :status => :created}
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /negotiations/1
  # PUT /negotiations/1.json
  def update
    @user = User.find(params[:user_id])
    @negotiation = @user.negotiations.find(params[:id])
    @negotiation.proposals.last.user_composer_id == @user._id ? @negotiation.proposals.last.cancel_composer : @negotiation.proposals.last.cancel_receiver

    proposal = Negotiation::Proposal.new(params[:proposal])
    proposal.user_composer_id = @user._id

    respond_to do |format|
      if @negotiation.proposals << proposal
        format.html { redirect_to @user, notice: 'Negotiation was successfully updated.' }
        format.js { render 'reload_negotiations', :layout => false }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /negotiations/1
  # DELETE /negotiations/1.json
  def destroy
    @negotiation = Negotiation.find(params[:id])
    @negotiation.destroy

    respond_to do |format|
      format.html { redirect_to user_negotiations_url }
    end
  end


  # Firma la propuesta
  def sign
    @negotiation = Negotiation.find(params[:id])
    proposal = @negotiation.proposals.last
    proposal.sign_receiver

    respond_to do |format|
      format.js { render :partial => "negotiations/reload_negotiations_list" }
    end
  end


  # Confirma la propuesta
  def confirm
    @negotiation = Negotiation.find(params[:id])

    respond_to do |format|
      if @negotiation.seal_deal
        format.js { render :partial => "negotiations/reload_negotiations_list" }
      else
        format.js { render :partial => "negotiations/reload_negotiations_list" }
      end
    end
  end


  # Cancela la propuesta
  def cancel
    @user = User.find(params[:user_id])
    @negotiation = Negotiation.find(params[:id])
    proposal = @negotiation.proposals.last
    proposal.user_composer_id == @user._id ? proposal.cancel_composer : proposal.cancel_receiver

    respond_to do |format|
      format.js { render :partial => "negotiations/reload_negotiations_list" }
    end
  end

  # Prueba el canal de Pusher
  def pusher_message
    @user = User.find(params[:user_id])
    @negotiation = params[:negotiation_id]
    @message = params[:message]
    Pusher.trigger('my_channel', 'my_event', {message: @message, negotiation_id: @negotiation, user: @user})
    respond_to do |format|
      format.js
    end
  end

end
