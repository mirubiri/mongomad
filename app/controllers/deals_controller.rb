class DealsController < ApplicationController

  layout 'exposition'

  def index
    @deals = Deal.all
    @requests = Request.where(user_id:current_user.id)

    respond_to do |format|
      format.html
      #format.json { render json: @deals }
    end
  end

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

  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy

    respond_to do |format|
      format.html { redirect_to deals_url }
      #format.json { head :no_content }
    end
  end
end
