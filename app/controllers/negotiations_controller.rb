class NegotiationsController < ApplicationController

  layout 'exposition'

  def index
    @negotiations = Negotiation.all
    # @requests = Request.where(user_id:current_user.id)
    @requests = Request.all

    respond_to do |format|
      format.html
      #format.json { render json: @negotiations }
    end
  end

  def edit
    @negotiation = Negotiation.find(params[:id])
  end

  def update
    @negotiation = Negotiation.find(params[:id])

    respond_to do |format|
      if @negotiation.update_attributes(params[:negotiation])
        format.html { redirect_to @negotiation, notice: 'Negotiation was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @negotiation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @negotiation = Negotiation.find(params[:id])
    @negotiation.destroy

    respond_to do |format|
      format.html { redirect_to negotiations_url }
      #format.json { head :no_content }
    end
  end
end
