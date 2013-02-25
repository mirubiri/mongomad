class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :proposals,   class_name: "Negotiation::Proposal", cascade_callbacks: true
  embeds_one :conversation, class_name: "Negotiation::Conversation",cascade_callbacks:true

  has_and_belongs_to_many :negotiators, class_name: "User"

  validates :proposals,
    :negotiators,
    :conversation,
    presence: true

  def self.generate(offer)
    proposal_params = self.proposal_params_from_offer(offer)
    message_params = self.message_params_from_offer(offer)

    negotiation = Negotiation.new(
      conversation: Negotiation::Conversation.new()
    )
    negotiation.propose(proposal_params)
    negotiation.post_message(message_params)
    negotiation.self_update
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

  def kick(negotiator)
    if negotiators.count >= 2
      negotiators.delete(negotiator)
    else
      finish
    end
  end

  def propose(proposal_params=[])
    proposal = Negotiation::Proposal.generate(proposal_params)
    proposal.publish
    self.proposals << proposal
  end

  def post_message(message_params=[])
    message = Negotiation::Proposal.new(
      #initial_message:message_params[:initial_message]
    )
    self.conversation.messages << message
  end

  private
  def self.proposal_params_from_offer(offer)
    {
      user_composer_id: offer.user_composer_id,
      user_receiver_id: offer.user_receiver_id,
      composer_things:  offer.composer.products.map do |product|
        { thing_id: product[:thing_id], quantity: product[:quantity] }
      end,
      receiver_things:  offer.receiver.products.map do |product|
        { thing_id: product[:thing_id], quantity: product[:quantity] }
      end,
      money: { user_id: offer.money.user_id, quantity: offer.money.quantity }
    }
  end

  def self.message_params_from_offer(offer)
    #{ initial_message: offer.initial_message }
  end
end
