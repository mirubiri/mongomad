class ProfilesController < ApplicationController

  def sub_layout
    "complete_layout"
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

  def update
    @user = current_user

    respond_to do |format|
      if @user.profile.update_attributes(params[:user_profile])
        format.html { redirect_to user_profile_path(current_user), notice: 'item was successfully updated.' }
        format.js { render :partial => 'profiles/reload_after_edit_profile', :layout => false }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
