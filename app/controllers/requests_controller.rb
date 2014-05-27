class RequestsController < ApplicationController

  layout 'exposition'

  def new
    @request = Request.new
    @requests = Request.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @request }
    end
  end

  def edit
    @request = Request.find(params[:id])
    @requests = Request.all
  end

  def create
    #@request = Request.new(params[:request])
    @request = Request.new
    @request.text = params[:request][:text]

    respond_to do |format|
      if @request.save
        format.html { redirect_to offers_url }
        format.json { render json: @request, status: :created, location: @request }
      else
        format.html { redirect_to @offers, notice: 'Request unable to be created.'  }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @request = Request.find(params[:id])

    respond_to do |format|
      if @request.update_attributes(params[:request])
        format.html { redirect_to offers_url, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to offers_url }
      format.json { head :no_content }
    end
  end
end
