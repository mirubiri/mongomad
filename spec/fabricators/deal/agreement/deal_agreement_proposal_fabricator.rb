Fabricator(:deal_agreement_proposal, class_name: "Deal::Agreement::Proposal") do
  transient        :proposal
  agreement        nil
  composer         { |attrs| Fabricate.build(:deal_agreement_proposal_composer, composer:attrs[:proposal].composer) }
  receiver         { |attrs| Fabricate.build(:deal_agreement_proposal_receiver, receiver:attrs[:proposal].receiver) }
  money            { |attrs| Fabricate.build(:deal_agreement_proposal_money, money:attrs[:proposal].money) }
  user_composer_id { |attrs| attrs[:proposal].user_composer_id }
  user_receiver_id { |attrs| attrs[:proposal].user_receiver_id }
end
