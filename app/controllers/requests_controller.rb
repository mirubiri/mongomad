class RequestsController < ApplicationController
  def sub_layout22
    "requests"
  end

  # GET /requests
  # GET /requests.json
  def index
    @user = User.find(params[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @requests }
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @request = Request.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/new
  # GET /requests/new.json
  def new
    @request = Request.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/1/edit
  def edit
    @request = Request.find(params[:id])
  end

  # POST /requests
  # POST /requests.json
  def create
    @user = current_user
    @request = Request.generate(params[:request])
    @request.user = @user
    @request.self_update

    respond_to do |format|
      if @request.publish
        format.html { redirect_to @user, notice: 'Request was successfully created.' }
        format.json { render json: @user, status: :created, location: @request }
      else
        format.html { redirect_to @user, notice: 'la peticicion no se ha creado' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.json
  def update
    @user = current_user
    @request = @user.resquests.find(params[:request][:request_id])
    @request.alter_contents(params[:request])
    @request.self_update

    respond_to do |format|
      if @request.publish
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request = Request.find(params[:id])
    @request.unpublish

    respond_to do |format|
      format.html { redirect_to user_offers_url }
      format.json { head :no_content }
    end
  end
end
