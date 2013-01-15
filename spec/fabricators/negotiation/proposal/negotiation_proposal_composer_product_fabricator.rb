Fabricator(:negotiation_proposal_composer_product, class_name: "Negotiation::Proposal::Composer::Product") do
  transient   :product
  composer    nil
  images      do |attrs|
    images = []
    attrs[:product].images.each do |image|
      images << Fabricate.build(:negotiation_proposal_composer_product_image, file:image.file)
    end
    images
  end
  thing_id    { |attrs| attrs[:product].thing_id }
  name        { |attrs| attrs[:product].name }
  description { |attrs| attrs[:product].description }
  quantity    { |attrs| attrs[:product].quantity }
  main_image  { |attrs| attrs[:product].main_image }
end
