class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :user_id,   type: Moped::BSON::ObjectId
  field :user_name, type: String
  field :text,      type: String
  field :image,     type: String

  validates :user_id,
            :user_name,
            :text,
            :image,
            presence: true
end
