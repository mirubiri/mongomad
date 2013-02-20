class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :proposals, class_name: "Negotiation::Proposal", cascade_callbacks: true

  has_and_belongs_to_many :negotiators, class_name: "User"

  validates :proposals,
    :negotiators,
    presence: true

  def self.start_with(offer)
    raise error unless offer.valid?

    negotiation = Negotiation.new

    proposal = Negotiation::Proposal.generate(offer)

    message = Negotiation::Message.new(
      user_name: offer.composer.name,
      text: offer.initial_message,
      image: offer.composer.image
    )

    negotiation.proposals << proposal
    negotiation.messages << message
    negotiation.negotiators << offer.user_composer
    negotiation.negotiators << offer.user_receiver

    negotiation.save
    negotiation
  end

  def kick(negotiator)
    if negotiators.count >= 2
      negotiators.delete(negotiator)
    else
      finish
    end
  end
end
