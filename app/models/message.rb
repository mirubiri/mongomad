class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :message_container, polymorphic: true

  field :_id, default:nil
  field :text

  def user_sheet
    message_container.user_sheets.find(id)
  end
end
