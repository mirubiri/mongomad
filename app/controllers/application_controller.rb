class ApplicationController < ActionController::Base  
  protect_from_forgery
  helper_method :user_visited, :user_logged

  before_filter :authenticate_user!, :set_request_variable
  helper :all
  
  def sub_layout
    "devise" 
  end

  def after_sign_in_path_for(resource)
    user_url(current_user)
  end

  private

  def user_logged
    current_user
  end

  def set_request_variable
    @request = Request.new
  end

  def user_visited(user_id)
    @user = User.find(params[:id])
  end

end
