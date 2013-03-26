class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :negotiators, class_name: "User"

  embeds_one  :conversation, class_name: "Negotiation::Conversation", cascade_callbacks: true
  embeds_many :proposals,    class_name: "Negotiation::Proposal", cascade_callbacks: true

  accepts_nested_attributes_for :conversation, :proposals

  validates :negotiators,
    :proposals,
    :conversation,
    presence: true

=begin
  def kick(negotiator)
    if negotiators.count >= 2
      negotiators.delete(negotiator)
    else
      finish
    end
  end

  def propose(proposal_params=[])
    proposal = Negotiation::Proposal.generate(proposal_params)
    self.proposals << proposal
    self.publish
  end

  def post_message(message_params=[])
    message = Negotiation::Proposal.new()
      #initial_message:message_params[:initial_message]

    self.conversation.messages << message
    self.publish
  end
=end
end
