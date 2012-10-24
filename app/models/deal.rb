class Deal
  include Mongoid::Document
  belongs_to :deal_box
  embeds_one :agreement
  embeds_one :conversation, as: :polymorphic_conversation
end
