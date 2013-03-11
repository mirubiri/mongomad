class Offer::Money
  include Mongoid::Document

  embedded_in :offer

  field :user_id,  type: Moped::BSON::ObjectId
  field :quantity, type: Integer

  validates :offer,
    :quantity,
    presence: true

  validates :quantity,
    allow_nil: false,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
=begin
  def alter_contents(params=[])
    self.user_id = params[:user_id]
    self.quantity = params[:quantity]
  end
=end
end
