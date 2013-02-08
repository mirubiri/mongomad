class Negotiation::Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :negotiation
  embeds_one  :composer, class_name: "Negotiation::Proposal::Composer", cascade_callbacks: true
  embeds_one  :receiver, class_name: "Negotiation::Proposal::Receiver", cascade_callbacks: true
  embeds_one  :money,    class_name: "Negotiation::Proposal::Money", cascade_callbacks: true

  field :user_composer_id, type: Moped::BSON::ObjectId
  field :user_receiver_id, type: Moped::BSON::ObjectId

  validates :negotiation,
            :composer,
            :receiver,
            :money,
            :user_composer_id,
            :user_receiver_id,
            presence: true

  def self.generate(offer)
    proposal = Negotiation::Proposal.new

    proposal.user_composer_id = offer.user_composer_id
    proposal.user_receiver_id = offer.user_receiver_id

    proposal.set_composer(offer.composer)
    proposal.set_receiver(offer.receiver)
    proposal.set_money(offer.money)
    proposal
  end

  def set_composer(composer)
    self.composer = Negotiation::Proposal::Composer.new
    self.composer.name = composer.name
    self.composer.image = composer.image
    self.composer.add_products(composer.products)
  end

  def set_receiver(receiver)
    self.receiver = Negotiation::Proposal::Receiver.new
    self.receiver.name = receiver.name
    self.receiver.image = receiver.image
    self.receiver.add_products(receiver.products)
  end

  def set_money(money)
    self.money = Negotiation::Proposal::Money.new
    self.money.user_id = money.user_id
    self.money.quantity = money.quantity
  end
end
