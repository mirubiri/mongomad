class ProfilesController < ApplicationController

  def sub_layout
    "profile"
  end

  def show
    @user = current_user
    respond_to do |format|
      format.html # show.html.erb
      format.js #show.js.erb
    end
  end

  def create
    @user = current_user
    respond_to do |format|
      format.html #show.html.erb
      format.js #show.js.erb
    end
  end

end
