Fabricator(:negotiation_proposal_receiver_product, class_name: "Negotiation::Proposal::Receiver::Product") do
  transient   :product
  receiver    nil
  images      do |attrs|
    images = []
    attrs[:product].images.each do |image|
      images << Fabricate.build(:negotiation_proposal_receiver_product_image, file:image.file)
    end
    images
  end
  thing_id    { |attrs| attrs[:product].thing_id }
  name        { |attrs| attrs[:product].name }
  description { |attrs| attrs[:product].description }
  quantity    { |attrs| attrs[:product].quantity }
  main_image  { |attrs| attrs[:product].main_image }
end
