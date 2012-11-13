class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  field :requester_id, type: Moped::BSON::ObjectId
  field :text, type: String

  validates :requester_id,
            :text,
            presence: true

  def publish
    self.save
  end
end