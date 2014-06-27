class ApplicationController < ActionController::Base
  def after_sign_in_path_for(user)
    offers_url
  end

  def visited_user
    User.find(params[:user_id])
  end

  @data = OpenStruct.new
  @data.visited_user = visited_user
  @data.requests = Request.where(user_id:@data.visited_user.id)
end
