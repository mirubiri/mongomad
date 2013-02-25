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

  def self.generate(offer)
    negotiation = Negotiation.new()
    negotiation.add_proposal(offer)
    negotiation.add_message(offer)
    self_update
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

  private
  def add_proposal(offer)
    self.proposals << Proposal.generate(offer)
  end

  def add_message(offer)
    message = Negotiation::Conversation::Message.new()
    self.conversation.messages << message
  end
end
