class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user_composer, class_name: 'User', inverse_of: :sent_offers
  belongs_to :user_receiver, class_name: 'User', inverse_of: :received_offers

  embeds_one :composer, class_name: 'Offer::Composer', cascade_callbacks: true
  embeds_one :receiver, class_name: 'Offer::Receiver', cascade_callbacks: true
  embeds_one :money,    class_name: 'Offer::Money', cascade_callbacks: true

  field :initial_message, type: String

  accepts_nested_attributes_for :composer, :receiver, :money

  validates :user_composer,
    :user_receiver,
    :composer,
    :receiver,
    :money,
    :initial_message,
    presence: true

  validates :initial_message,
    length: { minimum: 1, maximum: 160 }

  def start_negotiation
    negotiation_params = {
      negotiators: [ user_composer, user_receiver ],
      conversation_attributes: {
        messages_attributes: [ { user_id: user_composer_id, text: initial_message } ]
      },
      proposals_attributes: Array.new,
      token_attributes: { user_id: nil, state: nil }
    }

    negotiation_params[:proposals_attributes] << fill_proposal_hash

    negotiation = Negotiation.new(negotiation_params)
    negotiation.token.initialize_token

    negotiation.save
    negotiation
  end

  def fill_proposal_hash
    proposal_hash = {
      user_composer_id: self.user_composer_id,
      user_receiver_id: self.user_receiver_id
    }

    proposal_hash[:composer_attributes] = { products_attributes: Array.new }
    self.composer.products.each do |product|
      proposal_hash[:composer_attributes][:products_attributes] << {
        thing_id: product.thing_id,
        quantity: product.quantity
      }
    end

    proposal_hash[:receiver_attributes] = { products_attributes: Array.new }
    self.receiver.products.each do |product|
      proposal_hash[:receiver_attributes][:products_attributes] << {
        thing_id: product.thing_id,
        quantity: product.quantity
      }
    end

    proposal_hash[:money_attributes] = {
      user_id: self.money.user_id,
      quantity: self.money.quantity
    }
  end
end
