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
    proposal = new(user_composer_id:offer.user_composer_id,
                   user_receiver_id:offer.user_receiver_id )

    proposal.set_composer(offer.composer)
    proposal.set_receiver(offer.receiver)
    proposal.set_money(offer.money)
    proposal
  end

  def set_composer(offer_composer)
    build_composer(name:offer_composer.name,
                   image_name:offer_composer.image_name)
    composer.add_products(offer_composer.products)
  end

  def set_receiver(offer_receiver)
    build_receiver(name:offer_receiver.name,
                   image_name:offer_receiver.image_name)
    receiver.add_products(offer_receiver.products)
  end

  def set_money(offer_money)
    build_money(user_id:offer_money.user_id,
                quantity:offer_money.quantity)
  end
end
