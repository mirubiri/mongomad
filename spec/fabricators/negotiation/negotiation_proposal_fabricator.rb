Fabricator(:negotiation_proposal, class_name: "Negotiation::Proposal") do
  negotiation nil
  composer    { Fabricate.build(:negotiation_proposal_composer) }
  receiver    { Fabricate.build(:negotiation_proposal_receiver) }
  money       nil
end
