class UsersController < ApplicationController

  def show
    respond_to do |format|
      format.html
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy

    respond_to do |format|
      format.html { redirect_to user_url(data.current_user) }
      #format.json { head :no_content }
    end
  end
end
