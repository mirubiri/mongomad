class NegotiationsController < ApplicationController
  # GET /negotiations
  # GET /negotiations.json

  def sub_layout
    "negotiations"
  end

  def index
    @user = User.find(params[:user_id])
    @negotiation =  @user.negotiations.last

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
    @user = current_user
    @offer = @user.received_offers.find(params[:offer_id])

    respond_to do |format|
      if @offer.start_negotiation
        format.html { redirect_to @user, notice: 'Negotiation was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /negotiations/1
  # PUT /negotiations/1.json
  def update
    @user = current_user
    @negotiation = @user.negotiations.find(params[:id])

    @proposal = Negotiation::Proposal.new(params[:proposal])
    @proposal.user_composer_id = current_user.id

    respond_to do |format|
      if @negotiation.proposals << @proposal
      format.html { redirect_to @user, notice: 'Negotiation was successfully updated.' }
      format.js { render :partial => "negotiations/edit_proposal_in_negotiation", :layout => false}
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
end
