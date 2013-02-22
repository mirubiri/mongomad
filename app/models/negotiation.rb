class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :proposals, class_name: "Negotiation::Proposal", cascade_callbacks: true
  embeds_one :conversation, class_name: "Negotiation::Conversation",cascade_callbacks:true
  has_and_belongs_to_many :negotiators, class_name: "User"

  validates :proposals,
    :negotiators,
    :conversation,
    presence: true

  def kick(negotiator)
    if negotiators.count >= 2
      negotiators.delete(negotiator)
    else
      finish
    end
  end
end
