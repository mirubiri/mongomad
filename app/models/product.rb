class Product < Good
  include AutoUpdate

  field :_id,        type:Moped::BSON::ObjectId, default:nil
  field :name
  field :description

  auto_update :name, :description, :images, using: :item

  validates_presence_of  :_id, :user_id

  def withdraw
  end

  def sell
  end
end
