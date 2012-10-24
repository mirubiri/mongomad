class Negotiation
  include Mongoid::Document
  belongs_to :negotiation_box
  embeds_one :conversation, as: :polymorphic_conversation
  embeds_one :proposal_box

end
