class Deal
  include Mongoid::Document
  include Mongoid::Timestamps
  include Proposable
  include Conversation

  proposal_historic :true
end
