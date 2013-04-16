class Deal::Agreement
  include Mongoid::Document

  embedded_in :deal
  embeds_one  :conversation, class_name: 'Deal::Agreement::Conversation', cascade_callbacks: true
  embeds_many :proposals,    class_name: 'Deal::Agreement::Proposal', cascade_callbacks: true

  accepts_nested_attributes_for :conversation, :proposals

  validates :deal,
    :conversation,
    :proposals,
    presence: true
end
