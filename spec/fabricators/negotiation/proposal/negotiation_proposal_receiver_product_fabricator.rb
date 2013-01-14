Fabricator(:negotiation_proposal_receiver_product, class_name: "Negotiation::Proposal::Receiver::Product") do
  transient   :thing
  receiver    nil
  images      do |attrs|
    attrs[:thing].images.each do |image|
      Fabricate.build(:negotiation_proposal_receiver_product_image, file:image.file.url)
    end
  end
  thing_id    { |attrs| attrs[:thing]._id }
  name        { |attrs| attrs[:thing].name }
  description { |attrs| attrs[:thing].description }
  quantity    1
  main_image  { |attrs| attrs[:thing].main_image }
end
