class UserSheet
  include Mongoid::Document
  include Mongoid::Timestamps
  include Attachment::Images
  include AutoUpdate

  embedded_in :user_sheet_container, polymorphic:true

  field :_id,       type:Moped::BSON::ObjectId, default:nil
  field :nick
  field :first_name
  field :last_name
  field :location,  type: Array

  auto_update :nick, :first_name, :last_name, :location, :images, using: :current_sheet

  validates_presence_of :_id, :location
  validates_length_of   :nick, minimum: 1, maximum: 20
  validates_length_of   :first_name, :last_name, minimum: 1, maximum: 15

  def current_sheet
    User.find(id).sheet
  end
end
