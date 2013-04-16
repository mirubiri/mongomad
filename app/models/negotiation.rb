class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :negotiators, class_name: 'User', inverse_of: :negotiations

  embeds_one  :conversation, class_name: 'Negotiation::Conversation', cascade_callbacks: true
  embeds_many :proposals,    class_name: 'Negotiation::Proposal', cascade_callbacks: true

  accepts_nested_attributes_for :conversation, :proposals

  #validates :negotiators,
  validates :conversation,
    :proposals,
    presence: true
end
