class Offer
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_one :composer, as: :polymorphic_composer
  embeds_one :receiver, as: :polymorphic_receiver
  embeds_one :money, as: :polymorphic_money

  field :initial_message, type: String

  validates :composer,
            :receiver,
            :initial_message,
            presence: true
end