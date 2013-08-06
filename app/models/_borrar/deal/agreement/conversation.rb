class Deal::Agreement::Conversation
  include Mongoid::Document

  embedded_in :agreement, class_name: 'Deal::Agreement'
  embeds_many :messages,  class_name: 'Deal::Agreement::Conversation::Message', cascade_callbacks: true

  accepts_nested_attributes_for :messages

  validates :messages,
    presence: true
end
