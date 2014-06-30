class ApplicationController < ActionController::Base
  before_filter :data_variable_definition

  def after_sign_in_path_for(user)
    offers_url
  end

  def data_variable_definition
    @data = OpenStruct.new
    # @data.viewed_user = viewed_user
    # @data.requests = Request.where(user_id:@data.viewed_user.id)
  end

  def viewed_user
    #recuperar id del usuario
  end
end
