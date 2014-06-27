class NegotiationsController < ApplicationController

  def index
    @data.negotiations = Negotiation.all

    respond_to do |format|
      format.html
      #format.json { render json: @data.negotiations }
    end
  end

  def edit
    @data.negotiation = Negotiation.find(params[:id])

    respond_to do |format|
      format.html { render :template => "proposal/edit" }
      #format.json { render json: @data.offer }
    end

  end

  def update
    negotiation = Negotiation.find(params[:id])

    respond_to do |format|
      if negotiation.update_attributes(params[:negotiation])
        format.html { redirect_to negotiation, notice: 'Negotiation was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @data.negotiation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    negotiation = Negotiation.find(params[:id])
    negotiation.destroy

    respond_to do |format|
      format.html { redirect_to negotiations_url }
      #format.json { head :no_content }
    end
  end
end
