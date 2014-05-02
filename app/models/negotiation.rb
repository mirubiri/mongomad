class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps
  include Proposable

  proposal_historic :true

  has_one                 :offer
  embeds_many             :messages,   as: :message_container
end
