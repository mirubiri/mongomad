class Agreement
  include Mongoid::Document

  embedded_in :deal
  embeds_many :proposals, as: :polymorphic_proposal
  embeds_many :messages, as: :polymorphic_message

  validates :deal,
            :proposals,
            :messages,
            presence: true
end