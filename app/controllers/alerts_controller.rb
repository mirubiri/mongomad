class AlertsController < ApplicationController

  def sub_layout
    "alerts"
  end

  def index
    @user = current_user    

    respond_to do |format|
      format.html # index.html.erb
      format.js # render index.js.erb
    end
  end

end
