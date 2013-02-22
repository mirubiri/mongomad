Fabricator(:negotiation_proposal_composer, class_name: "Negotiation::Proposal::Composer") do
  transient :composer
  proposal  nil
  products  do |attrs|
    products = []
    attrs[:composer].products.each do |product|
      products << Fabricate.build(:negotiation_proposal_composer_product, product:product)
    end
    products
  end
  name      { |attrs| attrs[:composer].name }
  image_name { |attrs| attrs[:composer].image_name }
end
