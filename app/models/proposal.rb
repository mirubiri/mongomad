class Proposal
  include Mongoid::Document
  embedded_in :proposal_box
end
