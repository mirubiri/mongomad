class Offer::Offer
    include Mongoid::Document
    include Mongoid::Timestamps

    embeds_one :composer, cascade_callbacks: true
    embeds_one :receiver, cascade_callbacks: true
    embeds_one :money

    field :initial_message, type: String

    validates :composer,
              :receiver,
              :initial_message,
              presence: true
end