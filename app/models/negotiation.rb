class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :proposals, class_name: "Negotiation::Proposal", cascade_callbacks: true
  embeds_many :messages,  class_name: "Negotiation::Message", cascade_callbacks: true

  has_and_belongs_to_many :negotiators, class_name: "User"

  validates :proposals,
    :messages,
    :negotiators,
    presence: true

  def self.start_with(offer)
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

  def kick(user)
    puts "PENDING"
  end

  def do_new_proposal(hash)
    puts "PENDING"
  end

  def post_message(hash)
    puts "PENDING"
  end

  def can_propose?(user)
    puts "PENDING"
  end

  def propose_deal(user)
    puts "PENDING"
  end

  def can_close?(user)
    puts "PENDING"
  end

  def make_deal
    puts "PENDING"
  end

  def self_update
    puts "PENDING"
  end
end
