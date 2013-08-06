class Negotiation::Conversation
  include Mongoid::Document

  embedded_in :negotiation
  embeds_many :messages, class_name: 'Negotiation::Conversation::Message', cascade_callbacks: true

  accepts_nested_attributes_for :messages

  validates :messages,
    presence: true
end
