class Agreement
  include Mongoid::Document

  embedded_in :deal
  embeds_many :proposals, as: :proposal_parent,cascade_callbacks:true
  embeds_many :messages, as: :message_parent

  validates :deal,
            :proposals,
            presence: true
end