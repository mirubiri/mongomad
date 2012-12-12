Fabricator(:deal_agreement_proposal_money, class_name: "Deal::Agreement::Proposal::Money") do
  proposal nil
  user_id 'user_id'
  quantity 100
end
