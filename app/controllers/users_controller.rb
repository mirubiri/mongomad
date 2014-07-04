class UsersController < ApplicationController

  def show
    respond_to do |format|
      format.html { redirect_to user_offers_path(visited_user) }
    end
  end

  def destroy
  end

end
