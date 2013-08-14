Fabricator(:proposal) do
  transient :container
  proposal_container do |attrs|
    Fabricate.build(:offer, proposal: nil) if attrs[:container] == :offer
    Fabricate.build(:negotiartion, proposals: nil)if attrs[:container] == :negotiation
    Fabricate.build(:deal, proposals: nil)if attrs[:container] == :deal
  end
  sender_products { Fabricate.build(:product) }
  receiver_products { Fabricate.build(:product) }
  sender_id do |attrs|
    attrs[:container].sender._id if attrs[:container] == :offer
    attrs[:container].negotiators[0]._id if attrs[:container] == :negotiation
    attrs[:container].signers[0]._id if attrs[:container] == :deal
  end
end
