class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_one :composer, class_name: "Offer::Composer", cascade_callbacks: true
  embeds_one :receiver, class_name: "Offer::Receiver", cascade_callbacks: true
  embeds_one :money, class_name: "Offer::Money", cascade_callbacks: true

  field :initial_message, type: String

  validates :composer,
            :receiver,
            :initial_message,
            presence: true
end