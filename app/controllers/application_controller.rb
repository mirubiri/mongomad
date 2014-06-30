class ApplicationController < ActionController::Base
  before_filter :data_variable_definition

  def after_sign_in_path_for(user)
    offers_url
  end

  def data_variable_definition
    @data = OpenStruct.new
    # @data.visited_user = visited_user
    # @data.requests = Request.where(user_id:@data.visited_user.id)
  end

  def visited_user
    #recuperar id del usuario
  end
end
