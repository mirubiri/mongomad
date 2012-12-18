class ApplicationController < ActionController::Base  
  protect_from_forgery

  before_filter :authenticate_user!
  helper :all
  
  def sub_layout
    "devise" 
  end

  def after_sign_in_path_for(resource)
    user_url(current_user)
  end

end
