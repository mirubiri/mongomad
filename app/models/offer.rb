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

<<<<<<< HEAD
  def self.publish(offer_hash)
    user_composer = User.find(offer_hash[:user_composer_id])
    user_receiver = User.find(offer_hash[:user_receiver_id])
=======
  def self.generate_from(hash)
    user_composer = User.find(hash[:user_composer_id])
    user_receiver = User.find(hash[:user_receiver_id])
>>>>>>> 25cb4611e8ae103e31c766bac890ef873f2a5b6f


    offer = Offer.new
    offer.composer = Offer::Composer.new
    offer.composer.name = user_composer.profile.name
    offer.composer.image = File.open(user_composer.profile.image.path)
<<<<<<< HEAD
    offer_hash[:composer_things].keys.each do |key|
=======
    
    hash[:composer_things].keys.each do |key|
>>>>>>> 25cb4611e8ae103e31c766bac890ef873f2a5b6f
      t = User.find(user_composer._id).things.find(key)
      offer.composer.products << t.to_composer_product
    end


    offer.receiver = Offer::Receiver.new
    offer.receiver.name = user_receiver.profile.name
    offer.receiver.image = File.open(user_receiver.profile.image.path)
<<<<<<< HEAD
    offer_hash[:receiver_things].keys.each do |key|
=======
    
    hash[:receiver_things].keys.each do |key|
>>>>>>> 25cb4611e8ae103e31c766bac890ef873f2a5b6f
      t = User.find(user_receiver._id).things.find(key)
      offer.receiver.products << t.to_receiver_product
    end

    offer.money = Offer::Money.new
    offer.money.user = offer_hash[:money].keys.first
    offer.money = offer_hash[:money].values.first

    offer.user_composer_id = user_composer._id
    offer.user_receiver_id = user_receiver._id

<<<<<<< HEAD
    offer.initial_message = offer_hash[:initial_message]
=======
    offer.initial_message = hash[:initial_message]



>>>>>>> 25cb4611e8ae103e31c766bac890ef873f2a5b6f

  end
end
