class AlertsController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.js # render index.js.erb
    end
  end
end
