class Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :proposal_parent, polymorphic: true
  embeds_one :composer, as: :composer_parent,cascade_callbacks:true
  embeds_one :receiver, as: :receiver_parent,cascade_callbacks:true
  embeds_one :money, as: :money_parent

  validates :proposal_parent,
            :composer,
            :receiver,
            presence: true
end