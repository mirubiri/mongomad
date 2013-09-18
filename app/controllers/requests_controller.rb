class RequestsController < ApplicationController
  def sub_layout
    "requests"
  end

  # GET /requests
  # GET /requests.json
  def index
    @user = current_user

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @request = Request.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /requests/new
  # GET /requests/new.json
  def new
    @request = Request.new

    respond_to do |format|
      format.html # new.html.erb
      format.js # render new.js.erb }
    end
  end

  # GET /requests/1/edit
  def edit
    @request = Request.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(params[:request])
    @request.user = current_user
    @request.user_sheet=current_user.sheet

    respond_to do |format|
      if @request.save
        format.html { redirect_to @user, notice: 'Request was successfully created.' }
        format.js { render :partial => "requests/reload_requests_list", :layout => false, :locals => { :request => @request }, :status => :created }
      else
        format.html { redirect_to @user, notice: 'Request was not created.' }
        format.js { render  :partial => "requests/reload_requests_list", notice: 'Puta' }
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.json
  def update
    @user = current_user
    @request = Request.find(params[:id])

    respond_to do |format|
      if @request.update_attributes(params[:request])
        format.html { redirect_to user_path(current_user), notice: 'Request was successfully updated.' }
        format.js { render :partial => "requests/edit_request_in_list", :layout => false }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to user_offers_url }
    end
  end
end
