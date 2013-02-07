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

    proposal.build_composer.add_products(offer.composer.products)
    proposal.build_receiver.add_products(offer.receiver.products)
    proposal.build_money(user_id: offer.money.user_id,
                         quantity: offer.money.quantity)
    proposal
  end
end
