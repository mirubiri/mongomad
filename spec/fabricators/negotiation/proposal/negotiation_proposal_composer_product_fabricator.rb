Fabricator(:negotiation_proposal_composer_product, class_name: 'Negotiation::Proposal::Composer::Product') do
  transient   :product
  composer    nil
  thing_id    { |attrs| attrs[:product].thing_id }
  name        { |attrs| attrs[:product].name }
  description { |attrs| attrs[:product].description }
  quantity    { |attrs| attrs[:product].quantity }
end
