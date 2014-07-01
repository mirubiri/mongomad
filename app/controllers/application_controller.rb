class ApplicationController < ActionController::Base
  before_filter :data_variable_definition

  def after_sign_in_path_for(user)
    offers_url
  end

  def data_variable_definition
    data = OpenStruct.new
    data.current_user = current_user
    data.viewed_user = viewed_user
    data.current_user_items = Item.where(user_id:data.current_user.id)
    data.viewed_user_items = Item.where(user_id:data.viewed_user.id)

    data.omnibar = OpenStruct.new
    data.omnibar.avatar = data.current_user

    data.dashboard = OpenStruct.new
    data.dashboard.profile_card = data.viewed_user
    data.dashboard.request_list = Request.where(user_id:data.viewed_user.id)

    data.expositor = OpenStruct.new
    #TODO: Completar
    # data.expositor.items
    # data.expositor.offers
    # data.expositor.negotiations
    # data.expositor.deals
  end

  def viewed_user
    #TODO: Recuperar id del usuario
  end
end
