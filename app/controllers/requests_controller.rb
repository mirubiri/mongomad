class RequestsController < ApplicationController
  # GET /requests
  # GET /requests.json

  def sub_layout
    "requests" 
  end

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
    @user = current_user   
    @request = Request.new(params[:request][:text])
    @request.user = current_user

    respond_to do |format|
      if @request.save
        format.html { redirect_to @user, notice: 'Request was successfully created.' }
        format.js { 
          render :partial => "requests/reload_requests_list", :layout => false, :locals => { :request => @request }, :status => :created  
        }
      else
        format.html { redirect_to @user, notice: 'la peticicion no se ha creado' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.json
  def update
    @user = User.find(params[:user_id]) 
    @request = Request.find(params[:id])

    respond_to do |format|
      if @request.update_attributes(params[:request])
        format.html { redirect_to user_path(current_user), notice: 'Request was successfully updated.' }
        format.js { render :partial => "requests/edit_request_in_list", :layout => false
        }
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
    @request.destroy

    respond_to do |format|
      format.html { redirect_to user_offers_url }
      format.json { head :no_content }
    end
  end
end
