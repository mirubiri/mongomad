class Deal::Conversation
  include Mongoid::Document

  embedded_in :deal
  embeds_many :messages, class_name: 'Deal::Conversation::Message', cascade_callbacks: true

  accepts_nested_attributes_for :messages

  validates :deal,
    :messages,
    presence: true
end
