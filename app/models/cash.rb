class Cash < Good

  field :_id,      type:Moped::BSON::ObjectId,default:nil
  field :_money,   type:Money

  validates_presence_of :_money
end
