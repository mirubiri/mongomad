class ProposalBox
  include Mongoid::Document
  embedded_in :negotiation
  embeds_many :proposals
end
