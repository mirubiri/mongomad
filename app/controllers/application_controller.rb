class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  def current_user
    current_user_id = session[:current_user_id]
    @current_user = User.find(current_user_id)
  end

  def get_products_from_items(item_ids)
    item_ids.map { |id| Item.find(id[:item_id]).to_product }
  end

  def parse_cash(cash_params)
    cash = Cash.new(owner_id:cash_params[:owner_id])
    cash.money = Money.new(cash_params[:amount])
    cash.images << Attachment::Image.new(_id:'static/images/money', main:true)
    cash
  end

  helper_method :current_user
end
