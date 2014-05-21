class UsersController < ApplicationController

  layout 'exposition'

  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  # TODO: Eliminar al poner el devise
  def user_caption
    env['rack.session'][:current_user_id]= params[:user_id]
    @user = User.find(params[:user_id])
    redirect_to user_offers_url(@user)
  end
end
