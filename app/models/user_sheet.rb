class UserSheet
  include Mongoid::Document
  include Mongoid::Timestamps
  include Attachment::Images

  embedded_in :user_sheet_container, polymorphic:true

  field :_id,       type:Moped::BSON::ObjectId, default:nil
  field :nick
  field :first_name
  field :last_name
  field :location,  type: Array

  validates_presence_of :_id, :nick, :first_name, :last_name, :location
end
