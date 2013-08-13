class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :message_container, polymorphic: true
  embeds_one  :sheet, class_name:'UserSheet', as: :user_sheet_container

  field :text

  validates_presence_of :sheet, :text

  validates :text, length: { minimum: 1, maximum: 160 }

#   def user
#     conversation.negotiation.negotiators.find(user_id)
#   end
end
