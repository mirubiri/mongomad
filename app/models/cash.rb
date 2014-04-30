class Cash < Good
  field :money,    type:Money

  validates_presence_of :user_id, :money
end
