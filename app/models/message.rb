class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :message_container, polymorphic: true

  field :user_id, type:Moped::BSON::ObjectId
  field :text

  def user_sheet
    message_container.user_sheets.find(user_id)
  end
end
