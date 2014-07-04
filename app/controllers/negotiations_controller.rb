class NegotiationsController < ApplicationController

  def index
    respond_to do |format|
      format.html
      #format.json { render json: negotiations }
    end
  end

  def edit
    negotiation = Negotiation.find(params[:id])

    respond_to do |format|
      format.html { render :template => 'proposal/edit', locals:{ negotiation:negotiation } }
      #format.json { render json: negotiation }
    end

  end

  def update
    negotiation = Negotiation.find(params[:id])

    respond_to do |format|
      if negotiation.update_attributes(params[:negotiation])
        format.html { redirect_to negotiation, notice: 'Negotiation was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render 'index' }
        #format.json { render json: negotiation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    negotiation = Negotiation.find(params[:id])
    negotiation.destroy

    respond_to do |format|
      format.html { redirect_to user_negotiations_url(current_user) }
      #format.json { head :no_content }
    end
  end
end
