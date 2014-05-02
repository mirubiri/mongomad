class Deal
  include Mongoid::Document
  include Mongoid::Timestamps
  include Proposable

  proposal_historic :true

  embeds_many :messages,   as: :message_container
end
