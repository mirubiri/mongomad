class ProfilesController < ApplicationController

  def sub_layout
    "profile"
  end

  def edit
    @user = current_user

    respond_to do |format|
      format.html
      format.js
    end

  end

  def show
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.html # show.html.erb
      format.js #show.js.erb
    end
  end

  def create
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.html #show.html.erb
      format.js #show.js.erb
    end
  end

  

end
