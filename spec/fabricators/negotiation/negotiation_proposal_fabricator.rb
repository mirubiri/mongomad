Fabricator(:negotiation_proposal, class_name: "Negotiation::Proposal") do
  transient   :offer
  negotiation nil
  composer    { |attrs| Fabricate.build(:negotiation_proposal_composer, offer:attrs[:offer]) }
  receiver    { |attrs| Fabricate.build(:negotiation_proposal_receiver, offer:attrs[:offer]) }
  money       do |attrs|
    attrs[:offer].money && Fabricate.build(:negotiation_proposal_money, user_id:attrs[:offer].money.user_id, quantity:attrs[:offer].money.quantity)
  end
end
