Fabricator(:deal_agreement, class_name: "Deal::Agreement") do
  deal               nil
  proposals(count:1) { Fabricate.build(:deal_agreement_proposal) }
  messages           nil
end
