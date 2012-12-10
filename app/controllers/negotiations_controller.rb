class NegotiationsController < ApplicationController
  # GET /negotiations
  # GET /negotiations.json
  def index
    @user = current_user
    @requests = @user.requests.all.to_a
    @negotiations = Negotiation.all.to_a

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @negotiations }
    end
  end

  # GET /negotiations/1
  # GET /negotiations/1.json
  def show
    @negotiation = Negotiation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @negotiation }
    end
  end

  # GET /negotiations/new
  # GET /negotiations/new.json
  def new
    @negotiation = Negotiation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @negotiation }
    end
  end

  # GET /negotiations/1/edit
  def edit
    @negotiation = Negotiation.find(params[:id])
  end

  # POST /negotiations
  # POST /negotiations.json
  def create
    @negotiation = Negotiation.new(params[:negotiation])

    respond_to do |format|
      if @negotiation.save
        format.html { redirect_to @negotiation, notice: 'Negotiation was successfully created.' }
        format.json { render json: @negotiation, status: :created, location: @negotiation }
      else
        format.html { render action: "new" }
        format.json { render json: @negotiation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /negotiations/1
  # PUT /negotiations/1.json
  def update
    @negotiation = Negotiation.find(params[:id])

    respond_to do |format|
      if @negotiation.update_attributes(params[:negotiation])
        format.html { redirect_to @negotiation, notice: 'Negotiation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @negotiation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /negotiations/1
  # DELETE /negotiations/1.json
  def destroy
    @negotiation = Negotiation.find(params[:id])
    @negotiation.destroy

    respond_to do |format|
      format.html { redirect_to negotiations_url }
      format.json { head :no_content }
    end
  end
end
