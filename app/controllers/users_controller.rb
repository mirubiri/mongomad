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
      format.html { redirect_to users_url }
      #format.json { head :no_content }
    end
  end
end
