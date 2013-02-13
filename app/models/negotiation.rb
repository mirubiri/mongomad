class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :proposals, class_name: "Negotiation::Proposal", cascade_callbacks: true
  embeds_many :messages,  class_name: "Negotiation::Message", cascade_callbacks: true

  has_and_belongs_to_many :users

  field :token_user_id, type: Moped::BSON::ObjectId
  field :token_state,   type: Symbol

  validates :proposals,
            :messages,
            :users,
            :token_user_id,
            :token_state,
            presence: true

  validates :token_state, :inclusion => { :in => [:propose, :accept] }

  def self.open(params)
    offer = Offer.find(params[:offer_id])
    negotiation = new

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
    proposals << proposal
    self
  end

  def add_message(message)
    messages << message
    self
  end

  def set_users(offer)
    users << offer.user_composer
    users << offer.user_receiver
    self
  end

  def publish
   save && self
  end
end
