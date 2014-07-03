class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :define_data

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

  def define_data
    @data ||= DataValue.new
  end
end
