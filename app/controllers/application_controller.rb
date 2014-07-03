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
    def offers
      @offers ||= Offer.where("proposal.composer_id"=>visited_user.id)
    end

    def negotiations
      @negotiations ||= Negotiation.where(user_ids:current_user.id)
    end

    def deals
      @deals ||= Deal.where(user_ids:current_user.id)
    end

    def requests
      @requests ||= Request.where(user_id:visited_user.id)
    end

    def items
      @requests ||= Item.where(user_id:visited_user.id)
    end
  end

  def visited_user
    @_visited_user ||= User.find(params[:id])
  end

  def data
    @data ||= DataValue.new
  end
end
