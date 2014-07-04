class UserSheet
  include Mongoid::Document
  include Mongoid::Timestamps
  include Attachment::Images
  include AutoUpdate

  embedded_in :user_sheet_container, polymorphic:true

  field :_id,       type:BSON::ObjectId, default:nil
  field :nick
  field :full_name
  field :location,  type: Array

  auto_update :nick, :full_name, :location, :images, using: :current_sheet

  def current_sheet
    User.find(id).sheet
  end

  def first_name
    full_name.split.take 1
  end

  def surnames
    full_name.split.drop(1).join(' ')
  end
end
