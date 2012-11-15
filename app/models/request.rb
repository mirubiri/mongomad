class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  field :owner_id, type: Moped::BSON::ObjectId
  field :owner_name, type: String
  field :text, type: String

  validates :owner_id,
            :owner_name,
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