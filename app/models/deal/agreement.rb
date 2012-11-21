module Deal
  class Agreement
    include Mongoid::Document

    embedded_in :deal
    embeds_many :proposals, as: :polymorphic_proposal,cascade_callbacks:true
    embeds_many :messages, as: :polymorphic_message

    validates :deal,
              :proposals,
              presence: true
  end
end