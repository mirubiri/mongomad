class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  def current_user
    current_user_id = session[:current_user_id]
    @current_user = User.find(current_user_id)
  end

  helper_method :current_user #make this method available in views

end
