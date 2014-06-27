class RequestsController < ApplicationController

  def new
    @data.request = Request.new

    respond_to do |format|
      format.html
      #format.json { render json: @data.request }
    end
  end

  def edit
    @data.request = Request.find(params[:id])
  end

  def create
    builder = RequestBuilder.new
                            .user(@data.visited_user)
                            .text(params[:request][:text])
    request = builder.build

    respond_to do |format|
      if request
        request.save
        format.html { redirect_to offers_url }
        #format.json { render json: @data.request, status: :created, location: @data.request }
      else
        format.html { redirect_to @offers, notice: 'Request unable to be created.'  }
        #format.json { render json: @data.request.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    request = Request.find(params[:id])

    builder = RequestBuilder.new(request)
                            .text(params[:request][:text])
    request = builder.build

    respond_to do |format|
      if request
        request.save
        format.html { redirect_to offers_url, notice: 'Request was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @data.request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    request = Request.find(params[:id])
    request.destroy

    respond_to do |format|
      format.html { redirect_to offers_url }
      #format.json { head :no_content }
    end
  end
end
