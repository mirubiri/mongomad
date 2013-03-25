class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :proposals,   class_name: "Negotiation::Proposal", cascade_callbacks: true
  embeds_one :conversation, class_name: "Negotiation::Conversation", cascade_callbacks:true

  has_and_belongs_to_many :negotiators, class_name: "User"

  validates :proposals,
    :conversation,
    :negotiators,
    presence: true

=begin
  def self.generate(offer)
    proposal_params = self.proposal_params_from_offer(offer)
    message_params = self.message_params_from_offer(offer)

    negotiation = Negotiation.new(
      conversation: Negotiation::Conversation.new()
    )

    negotiation.propose(proposal_params)
    negotiation.post_message(message_params)
    negotiation.negotiators << offer.composer
    negotiation.negotiators << offer.receiver
    negotiation
    #negotiation.self_update
  end

  def publish
    save
  end

  def unpublish
    destroy
  end

  def self_update
    reload if persisted?
    proposals.each do |proposal|
      proposal.self_update
    end
    conversation.self_update
    self
  end
=end

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
end
