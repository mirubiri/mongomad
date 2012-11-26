class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_one :composer, as: :composer_parent,cascade_callbacks: true
  embeds_one :receiver, as: :receiver_parent,cascade_callbacks: true
  embeds_one :money, as: :money_parent, cascade_callbacks: true

  field :initial_message, type: String

  validates :composer,
            :receiver,
            :initial_message,
            presence: true
end