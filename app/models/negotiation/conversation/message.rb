class Negotiation::Conversation::Message
  include Mongoid::Document

  embedded_in :conversation, class_name: "Negotiation::Conversation"

  validates :conversation, presence: true

  def self_update
    self
  end
end
