class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :data,:visited_user
  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || user_offers_path(current_user)
  end

  def layout_by_resource
    if devise_controller?
      'welcome'
    else
      "application"
    end
  end

  class DataValue
    def initialize(current_user,visited_user)
      @visited_user=visited_user
      @current_user=current_user
    end

    def requests
      @requests ||= Request.where(user_id:visited_user.id)
    end

    def visited_user
      @visited_user
    end

    def current_user
      @current_user
    end

    def offers
      @offers ||= Offer.where("proposal.composer_id"=>visited_user.id)
    end

    def negotiations
      @negotiations ||= Negotiation.where(user_ids:current_user.id)
    end

    def deals
      @deals ||= Deal.where(user_ids:current_user.id)
    end

    def my_items
      @my_items ||= Item.where(user_id:current_user.id)
    end

    def his_items
      @his_items ||= Item.where(user_id:visited_user.id)
    end

    alias_method :items, :my_items
  end

  def visited_user
    user_id = params[:user_id] || params[:id]
    @_visited_user ||= User.find(user_id) if user_id
  end

  def data
    @data ||= DataValue.new(current_user,visited_user)
  end
end
