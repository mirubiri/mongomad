module Offer
  class offer
    include Mongoid::Document
    include Mongoid::Timestamps

    embedded_in :polymorphic_offer, polymorphic: true
    embeds_one :composer, as: :polymorphic_composer,cascade_callbacks:true
    embeds_one :receiver, as: :polymorphic_receiver,cascade_callbacks:true
    embeds_one :money, as: :polymorphic_money

    validates :polymorphic_offer,
              :composer,
              :receiver,
              presence: true
  end
end