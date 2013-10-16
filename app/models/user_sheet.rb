class UserSheet
  include Mongoid::Document
  include Mongoid::Timestamps
  include Attachment::Images

  embedded_in :user_sheet_container, polymorphic:true

  field :first_name
  field :last_name
  field :nick
  field :_id,type:Moped::BSON::ObjectId, default:nil
  field :location, type: Array

  validates_presence_of :first_name, :last_name, :nick, :_id, :location
end
