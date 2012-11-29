Fabricator(:negotiation_proposal, class_name: "Negotiation::Proposal") do
  negotiation nil
  composer        nil
  receiver        nil
end