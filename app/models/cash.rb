class Cash < Good

  field :owner_id, type:Moped::BSON::ObjectId
  field :money,    type:Money

  validates_presence_of :owner_id, :money
end
