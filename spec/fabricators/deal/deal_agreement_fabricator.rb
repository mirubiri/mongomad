Fabricator(:deal_agreement, class_name: "Deal::Agreement") do
  transient :negotiation
  deal      nil
  proposals do |attrs|
    proposals = []
    attrs[:negotiation].proposals.each do |proposal|
      proposals << Fabricate.build(:deal_agreement_proposal, proposal:proposal)
    end
    proposals
  end
  messages do |attrs|
    messages = []
    attrs[:negotiation].messages.each do |message|
      messages << Fabricate.build(:deal_agreement_message, message:message)
    end
    messages
  end
end
