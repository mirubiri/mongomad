class UsersController < ApplicationController

  layout 'exposition'

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    @item = Item.new
    @requests = Request.where(user_id:current_user.id)

    respond_to do |format|
      format.html
      #format.json { render json: @item }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      #format.json { head :no_content }
    end
  end
end
