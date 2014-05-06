class HomeController < ApplicationController

  layout 'welcome'
  
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
