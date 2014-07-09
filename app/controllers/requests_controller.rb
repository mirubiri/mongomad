class RequestsController < ApplicationController

  def create
    builder = RequestBuilder.new
                            .user(current_user)
                            .text(params[:request][:text])
    request = builder.build

    respond_to do |format|
      if request
        request.save
        format.html { redirect_to user_offers_url(current_user) }
        #format.json { render json: request, status: :created, location: request }
      else
        format.html { redirect_to user_offers_url(current_user), notice: 'Request unable to be created.'  }
        #format.json { render json: request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    request = Request.find(params[:id])
    request.destroy

    respond_to do |format|
      format.html { redirect_to user_offers_url(current_user) }
      #format.json { head :no_content }
    end
  end

end
