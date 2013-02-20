class Negotiation::Conversation
  include Mongoid::Document
  embedded_in :negotiation
  embeds_many :messages, class_name:"Negotiation::Conversation::Message",cascade_callbacks:true
  validates :negotiation, presence:true
end
