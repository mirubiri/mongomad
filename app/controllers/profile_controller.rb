class ProfileController < ApplicationController

  def sub_layout
    "profile"
  end

  def show
    @user = User.find(params[:id])
    @offers = @user.received_offers

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

end
