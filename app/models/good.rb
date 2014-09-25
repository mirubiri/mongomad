class Good
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id,type: BSON::ObjectId

  embedded_in :proposal
end
