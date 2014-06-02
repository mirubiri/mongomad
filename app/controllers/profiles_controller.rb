class ProfilesController < ApplicationController
  
  layout 'exposition'

  def show
    @profile = Profile.new
    @requests = Request.all

    respond_to do |format|
      format.html
      #format.json { render json: @items }
    end
  end

end
