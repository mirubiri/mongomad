class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: Moped::BSON::ObjectId
  field :user_name, type: String
  field :text, type: String

  validates :user_id,
            :user_name,
            :text,
            presence: true
end
