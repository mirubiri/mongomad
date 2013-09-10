class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :message_container, polymorphic: true

  field :text

  validates_presence_of :text

  validates :text, length: { minimum: 1, maximum: 160 }
end
