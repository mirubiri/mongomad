class Deal
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_one :agreement
  embeds_many :messages, as: :polymorphic_message

  validates :agreement, presence: true
end