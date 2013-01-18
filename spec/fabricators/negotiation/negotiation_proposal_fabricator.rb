Fabricator(:negotiation_proposal, class_name: "Negotiation::Proposal") do
  transient   :offer
  negotiation nil
  composer    { |attrs| Fabricate.build(:negotiation_proposal_composer, composer:attrs[:offer].composer) }
  receiver    { |attrs| Fabricate.build(:negotiation_proposal_receiver, receiver:attrs[:offer].receiver) }
  money       { |attrs| Fabricate.build(:negotiation_proposal_money, money:attrs[:offer].money) }
end
