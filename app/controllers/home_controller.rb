class HomeController < ApplicationController

  layout 'welcome'

  def show
    respond_to do |format|
      format.html
    end
  end

end
