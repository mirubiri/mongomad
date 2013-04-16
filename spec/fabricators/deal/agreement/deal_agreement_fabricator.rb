Fabricator(:deal_agreement, class_name: 'Deal::Agreement') do
  transient :negotiation
  deal      nil
  conversation { |attrs| Fabricate.build(:deal_agreement_conversation, conversation:attrs[:negotiation].conversation) }
  proposals do |attrs|
    proposals = []
    attrs[:negotiation].proposals.each do |proposal|
      proposals << Fabricate.build(:deal_agreement_proposal, proposal:proposal)
    end
    proposals
  end
end
