Fabricator(:negotiation_proposal_composer_product, class_name: "Negotiation::Proposal::Composer::Product") do
  composer nil
  thing_id 'thing_id'
  name 'name'
  description 'description'
  quantity 5
  main_image { File.open('app/assets/images/rails.png') }
end