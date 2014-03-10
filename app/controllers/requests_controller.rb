class RequestsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @requests = @user.requests.desc(:updated_at)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @user = User.find(params[:user_id])
    @request = Request.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @user = User.find(params[:user_id])
    @request = Request.new

    respond_to do |format|
      format.js # render new.js.erb
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @request = Request.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
      format.js # render edit.js.erb
    end
  end

  def create
    @user = User.find(params[:user_id])
    @request = Request.new(user:@user, user_sheet:@user.sheet, text:params[:request][:text])

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @request.save
        format.html { redirect_to @user, notice: 'Request has been successfully created.' }
        format.js { render 'add_request_in_list', :layout => false, :locals => { :request => @request }, :status => :created }
      else
        format.html { redirect_to @user, notice: 'Request has not been created.' }
        format.js { render 'add_request_in_list' }
      end
    end
  end

  def update
    @user = User.find(params[:user_id])
    @request = Request.find(params[:id])
    @request.text = params[:request][:text]

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @request.save
        format.html { redirect_to user_path(@user), notice: 'Request has been successfully updated.' }
        format.js { render 'reload_requests', :layout => false }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @request = Request.find(params[:id])

    #TODO: REVISAR SERGIO
    respond_to do |format|
      if @request.destroy
        format.html { redirect_to user_offers_url }
      else
        # ni idea :)
      end
    end
  end
end
