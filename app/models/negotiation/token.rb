class Negotiation::Token
  include Mongoid::Document

  embedded_in :negotiation

  field :user_id, type: Moped::BSON::ObjectId
  field :state,   type: Symbol

  validates :user_id,
    :state,
    presence: true

  validates :state,
    :inclusion => { :in => [:propose, :accept] }
end
