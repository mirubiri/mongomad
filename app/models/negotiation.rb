class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :proposals, class_name: "Negotiation::Proposal", cascade_callbacks: true
  embeds_many :messages,  class_name: "Negotiation::Message", cascade_callbacks: true

  has_and_belongs_to_many :users

  validates :proposals,
            :messages,
            :users,
            presence: true

  def self.open(offer)
    negotiation = Negotiation.new

    proposal = Negotiation::Proposal.generate(offer)
    negotiation.add_proposal(proposal)

    message = Negotiation::Message.new(
      user_name: offer.composer.name,
      text: offer.initial_message,
      image: offer.composer.image)
    negotiation.add_message(message)

    negotiation.set_users(offer)
  end

  def add_proposal(proposal)
    self.proposals << proposal
    self
  end

  def add_message(message)
    self.messages << message
    self
  end

  def set_users(offer)
    self.users << offer.user_composer
    self.users << offer.user_receiver
    self
  end

  def publish
    self.save && self
  end
end
