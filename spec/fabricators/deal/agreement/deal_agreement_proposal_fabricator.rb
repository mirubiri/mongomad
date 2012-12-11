Fabricator(:deal_agreement_proposal, class_name: "Deal::Agreement::Proposal") do
  agreement nil
  composer  { Fabricate.build(:deal_agreement_proposal_composer) }
  receiver  { Fabricate.build(:deal_agreement_proposal_receiver) }
  money     { Fabricate.build(:deal_agreement_proposal_money) }
end
