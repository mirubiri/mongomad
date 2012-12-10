Fabricator(:negotiation_proposal_composer, class_name: "Negotiation::Proposal::Composer") do
  proposal          nil
  products(count:1) { Fabricate.build(:negotiation_proposal_composer_product) }
  user_id           'user_id'
  name              'name'
  image             'app/assets/images/rails.png'
end