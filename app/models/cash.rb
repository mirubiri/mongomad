class Cash < Good
  field :amount
  field :_id, default:'cash'

  def to_product
    self
  end
end
