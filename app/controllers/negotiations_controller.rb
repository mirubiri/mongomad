class NegotiationsController < ApplicationController
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
    @user = receiver(proposal(@negotiation))

    respond_to do |format|
      format.html # edit.html.erb
      format.js # render edit.js.erb }
    end
  end

  # POST /negotiations
  # POST /negotiations.json
  def create
    @user = User.find(params[:user_id])
    @offer = Offer.find(params[:offer_id])
    # @offer = Fabricate.build(:offer)

    # puts "************************************"
    @offer.valid?
    # puts "************************************"

    @negotiation = Fabricate.build(:negotiation, offer:@offer)

    respond_to do |format|
      if @negotiation.save
         # puts "************************************"
          # puts "guarda la negociacion"
          # puts "************************************"
        format.html { redirect_to user_negotiations_path, notice: 'Negotiation was successfully created.' }
        format.js {render 'add_negotiation_in_list', :layout => false, :locals => { :negotiation => @negotiation }, :status => :created}
      else
        # puts "************************************"
          # puts "no guarda la negociacion"
          #puts @negotiation.errors.message
          # puts "************************************"
        format.html { render action: "new" }
      end
    end
  end

  # PUT /negotiations/1
  # PUT /negotiations/1.json
  def update
    @user = User.find(params[:user_id])
    @negotiation = negotiations(@user).find(params[:id])
    id(composer(proposal(@negotiation))) == id(@user) ? proposal(@negotiation).cancel_composer : proposal(@negotiation).cancel_receiver

    proposal = Negotiation::Proposal.new(params[:proposal])
    proposal.composer_id = id(@user)

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
  #TODO: REVISAR
  def sign
    @negotiation = Negotiation.find(params[:id])
    proposal(@negotiation).sign_receiver

    respond_to do |format|
      format.js { render :partial => "negotiations/reload_negotiations_list" }
    end
  end

  # Confirma la propuesta
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

  # Cancela la propuesta
  #TODO: REVISAR
  def cancel
    @user = User.find(params[:user_id])
    @negotiation = Negotiation.find(params[:id])

    id(composer(proposal(@negotiation))) == id(@user) ? proposal(@negotiation).cancel_composer : proposal(@negotiation).cancel_receiver

    respond_to do |format|
      format.js { render :partial => "negotiations/reload_negotiations_list" }
    end
  end

  # Prueba el canal de Pusher
  def pusher_message
    @user = User.find(params[:user_id])
    Pusher.trigger('my_channel', 'my_event', {message: params[:message], negotiation_id: params[:negotiation_id], sender_image_tag: params[:sender_image_tag] })
    respond_to do |format|
      format.js
    end
  end
end
