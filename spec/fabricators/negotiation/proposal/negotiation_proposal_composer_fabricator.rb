Fabricator(:negotiation_proposal_composer, class_name: "Negotiation::Proposal::Composer") do
  transient :offer
  proposal  nil
  products  do |attrs|
    products = []
    attrs[:offer].composer.products.each do |product|
      products << Fabricate.build(:negotiation_proposal_composer_product, product:product)
    end
    products
  end
  user_id   { |attrs| attrs[:offer].composer.user_id }
  name      { |attrs| attrs[:offer].composer.name }
  image     { |attrs| attrs[:offer].composer.image }
end
