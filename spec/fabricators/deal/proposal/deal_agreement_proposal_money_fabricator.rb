Fabricator(:deal_agreement_proposal_money, class_name: 'Deal::Agreement::Proposal::Money') do
  transient :money
  proposal  nil
  user_id   { |attrs| attrs[:money].user_id }
  quantity  { |attrs| attrs[:money].quantity }
end
