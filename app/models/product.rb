class Product < Good
  include Attachment::Images
  include AutoUpdate

  field :_id, type:BSON::ObjectId, default:nil
  field :name
  field :description
  field :sold, type: Boolean
  field :retired, type: Boolean

  auto_update :name, :description, :images, using: :item
end
