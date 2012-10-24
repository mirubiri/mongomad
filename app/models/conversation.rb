class Conversation
  include Mongoid::Document
  embedded_in :polymorphic_conversation, polymorphic: true
  embeds_many :messages
end
