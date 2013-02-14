class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_one :composer, class_name: "Offer::Composer", cascade_callbacks: true
  embeds_one :receiver, class_name: "Offer::Receiver", cascade_callbacks: true
  embeds_one :money,    class_name: "Offer::Money", cascade_callbacks: true

  belongs_to :user_composer, class_name: 'User', inverse_of: :sent_offers
  belongs_to :user_receiver, class_name: 'User', inverse_of: :received_offers

  field :initial_message, type: String

  validates :composer,
    :receiver,
    :money,
    :user_composer,
    :user_receiver,
    :initial_message,
    presence: true

  def self.generate(params)
    offer = new(
      user_composer: User.find(params[:user_composer_id]),
      user_receiver: User.find(params[:user_receiver_id]),
      initial_message: params[:initial_message]
    )

    offer.build_composer.add_products(params[:composer_things])
    offer.build_receiver.add_products(params[:receiver_things])
    offer.build_money(user_id: params[:money][:user_id],
                      quantity: params[:money][:quantity])
    offer.self_update
  end

  def self_update
    reload if persisted?
    receiver.self_update
    composer.self_update
    self
  end

  def publish
    save && self
  end

  def unpublish
    destroy
  end

  def start_negotiation
    Negotiation.start_with(self)
  end
end
