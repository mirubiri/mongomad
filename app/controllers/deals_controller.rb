class DealsController < ApplicationController

  layout 'exposition'

  # GET /deals
  # GET /deals.json
  def index
    @deals = Deal.all
    @requests = Request.all

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @deals }
    end
  end

  # PUT /deals/1
  # PUT /deals/1.json
  def update
    @deal = Deal.find(params[:id])

    respond_to do |format|
      if @deal.update_attributes(params[:deal])
        format.html { redirect_to @deal, notice: 'Deal was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy

    respond_to do |format|
      format.html { redirect_to deals_url }
      #format.json { head :no_content }
    end
  end
end
