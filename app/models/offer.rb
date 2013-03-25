class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user_composer, class_name: 'User', inverse_of: :sent_offers
  belongs_to :user_receiver, class_name: 'User', inverse_of: :received_offers

  embeds_one :composer, class_name: "Offer::Composer", cascade_callbacks: true
  embeds_one :receiver, class_name: "Offer::Receiver", cascade_callbacks: true
  embeds_one :money,    class_name: "Offer::Money", cascade_callbacks: true

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
end
