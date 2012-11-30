Fabricator(:deal_agreement_proposal_composer, class_name: "Deal::Agreement::Proposal::Composer") do
  proposal          nil
  products(count:1) { Fabricate.build(:deal_agreement_proposal_composer_product) }
  user_id           'user_id'
  name              'name'
  image             { File.open('app/assets/images/rails.png') }
end