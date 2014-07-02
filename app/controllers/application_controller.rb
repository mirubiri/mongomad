class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :data_variable_definition

  def after_sign_in_path_for(user)
    user_offers_url(current_user)
  end

  def data_variable_definition
    @data = OpenStruct.new
    current_user = User.first
    @data.viewed_user = User.first
    current_user_items = Item.where(user_id:current_user.id)
    @data.viewed_user_items = Item.where(user_id:@data.viewed_user.id)

    @data.omnibar = OpenStruct.new
    @data.omnibar.avatar = current_user

    @data.dashboard = OpenStruct.new
    @data.dashboard.profile_card = @data.viewed_user
    @data.dashboard.request_list = Request.where(user_id:@data.viewed_user.id)

    @data.expositor = OpenStruct.new
    #TODO: Completar
    # @data.expositor.items
    # @data.expositor.offers
    # @data.expositor.negotiations
    # @data.expositor.deals
  end

  def viewed_user
    #TODO: Recuperar id del usuario
  end
end
