class ApplicationController < ActionController::Base  
  protect_from_forgery

  before_filter :authenticate_user!, :set_request_variable
  helper :all
 
  def after_sign_in_path_for(resource)
    user_url(current_user)
  end

  private
  def set_request_variable
    @request = Request.new
  end  
end
