Fabricator(:deal_agreement_proposal_receiver_product, class_name: "Deal::Agreement::Proposal::Receiver::Product") do
 transient   :product
  receiver    nil
  images      do |attrs|
    images = []
    attrs[:product].images.each do |image|
      #images << Fabricate.build(:deal_agreement_proposal_receiver_product_image, file:File.open(image.file.url))
      images << Fabricate.build(:deal_agreement_proposal_receiver_product_image, file:File.open('app/assets/images/rails.png'))
    end
    images
  end
  thing_id    { |attrs| attrs[:product].thing_id }
  name        { |attrs| attrs[:product].name }
  description { |attrs| attrs[:product].description }
  quantity    { |attrs| attrs[:product].quantity }
  main_image  { |attrs| attrs[:images].last.file.url }
end
