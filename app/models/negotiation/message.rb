class Negotiation::Message
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :negotiation

  field :user_id,   type: Moped::BSON::ObjectId
  field :user_name, type: String
  field :text,      type: String
  field :image,     type: String

  validates :negotiation,
            :user_id,
            :user_name,
            :text,
            :image,
            presence: true
end
