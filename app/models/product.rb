class Product < Good
  include Attachment::Images
  include AutoUpdate

  field :_id,        type:BSON::ObjectId, default:nil
  field :name
  field :description

  auto_update :name, :description, :images, using: :item

  def withdraw
  end

  def sell
  end
end
