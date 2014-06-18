class HomeController < ApplicationController
  layout 'welcome'

  def index
    respond_to do |format|
      format.html
    end
  end
end
