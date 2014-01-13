class ProfilesController < ApplicationController

  def edit
    @user = User.find(params[:user_id])

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

  def update
    @user = User.find(params[:user_id])

    respond_to do |format|
      if @user.profile.update_attributes(params[:user_profile])
        format.html { redirect_to user_profile_path(@user), notice: 'item was successfully updated.' }
        format.js { render 'reload_after_edit_profile', :layout => false }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
