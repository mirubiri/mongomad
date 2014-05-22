class Good
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id,type: Moped::BSON::ObjectId

  embedded_in :proposal

  def to_product
  	self
  end
end
