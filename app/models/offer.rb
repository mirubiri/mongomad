class Offer
  # include Mongoid::Document
  # include Mongoid::Timestamps

  # embeds_one :composer, class_name: "Offer::Composer", cascade_callbacks: true
  # embeds_one :receiver, class_name: "Offer::Receiver", cascade_callbacks: true
  # embeds_one :money,    class_name: "Offer::Money", cascade_callbacks: true

  # belongs_to :user_composer, class_name: 'User', inverse_of: :sent_offers
  # belongs_to :user_receiver, class_name: 'User', inverse_of: :received_offers

  # field :initial_message, type: String

  # validates :composer,
  #   :receiver,
  #   :money,
  #   :user_composer,
  #   :user_receiver,
  #   :initial_message,
  #   presence: true

=begin
  def self.generate(offer_params=[])
    offer = new(
      user_receiver: User.find(offer_params[:user_receiver_id]),
      initial_message: offer_params[:initial_message]
    )
    offer.build_composer.add_products(offer_params[:composer_things])
    offer.build_receiver.add_products(offer_params[:receiver_things])
    offer.build_money(user_id: offer_params[:money][:user_id],
                      quantity: offer_params[:money][:quantity])
    offer
  end


  def alter_contents(offer_params=[])
    composer.alter_contents(offer_params[:composer_things])
    receiver.alter_contents(offer_params[:receiver_things])
    money.alter_contents(offer_params[:money])
    self.initial_message = offer_params[:initial_message]
    true
  end

  def publish
    save
  end

  def unpublish
    destroy
  end

  def self_update
    reload if persisted?
    receiver.self_update
    composer.self_update
    self
  end
=end
end
