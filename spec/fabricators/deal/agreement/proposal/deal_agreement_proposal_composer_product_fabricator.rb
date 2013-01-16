Fabricator(:deal_agreement_proposal_composer_product, class_name: "Deal::Agreement::Proposal::Composer::Product") do
 transient   :product
  composer    nil
  images      do |attrs|
    images = []
    attrs[:product].images.each do |image|
      #images << Fabricate.build(:deal_agreement_proposal_composer_product_image, file:File.open(image.file.url))
      images << Fabricate.build(:deal_agreement_proposal_composer_product_image, file:File.open('app/assets/images/rails.png'))
    end
    images
  end
  thing_id    { |attrs| attrs[:product].thing_id }
  name        { |attrs| attrs[:product].name }
  description { |attrs| attrs[:product].description }
  quantity    { |attrs| attrs[:product].quantity }
  main_image  { |attrs| attrs[:images].last.file.url }
end
