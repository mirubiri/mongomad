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

  def unpublish
    if self.persisted?
      self.delete #Always returns 'true'
    else
      return false
    end
  end
end