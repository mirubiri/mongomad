class Negotiation::Proposal::Money
  include Mongoid::Document

  embedded_in :proposal, class_name: "Negotiation::Proposal"

  field :user_id,  type: Moped::BSON::ObjectId
  field :quantity, type: Integer

  validates :proposal,
    :quantity,
    presence: true

  validates :quantity,
    allow_nil: false,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
=begin
  def self_update
    self.user_id = params[:user_id]
    self.quantity = params[:quantity]
    self
  end
=end
end
