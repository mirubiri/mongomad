class Cash < Good

  field :_id,      type:Moped::BSON::ObjectId,default:nil
  field :_money,   type:Money
  field :owner_id, type:Moped::BSON::ObjectId

  validates_presence_of :_money, :owner_id
end
