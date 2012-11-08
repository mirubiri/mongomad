class Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :polymorphic_proposal, polymorphic: true
  embeds_one :composer, as: :polymorphic_composer
  embeds_one :receiver, as: :polymorphic_receiver
  embeds_one :money, as: :polymorphic_money

  validates :polymorphic_proposal,
            :composer,
            :receiver,
            presence: true
end