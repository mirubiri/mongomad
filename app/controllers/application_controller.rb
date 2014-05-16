class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  # TODO: Una vez insertado devise todo esto se debe quitar
  def current_user
    current_user_id = session[:current_user_id]
    @current_user = User.find(current_user_id)
  end

  helper_method :current_user

end
