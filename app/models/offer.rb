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

  def generate_from(hash)
    user_composer = User.find(hash[:user_composer_id])
    user_receiver = User.find(hash[:user_receiver_id])

    offer = Offer.new
    offer.composer = Offer::Composer.new
    offer.composer.name = user_composer.profile.name
    offer.composer.image = File.open(user_composer.profile.image.path)
    hash[:composer_things].keys.each do |key|
      t = User.find(user_composer._id).things.find(key)
      offer.composer.products << t.to_composer_product
    end


    offer.receiver = Offer::Receiver.new
    offer.receiver.name = user_receiver.profile.name
    offer.receiver.image = File.open(user_receiver.profile.image.path)
    hash[:receiver_things].keys.each do |key|
      t = User.find(user_receiver._id).things.find(key)
      offer.receiver.products << t.to_receiver_product
    end

    offer.money = Offer::Money.new
    offer.money.user = hash[:money].keys.first
    offer.money = hash[:money].values.first

    offer.user_composer_id = user_composer._id
    offer.user_receiver_id = user_receiver._id

    offer.initial_message = hash[:initial_message]





  end
end
