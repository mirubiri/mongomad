Fabricator(:offer_composer_product_image, class_name: "Offer::Composer::Product::Image") do
  product  { Fabricate.build(:offer_receiver_product, images:nil) }
  file     'path'

  after_build do |image|
  	image.product.try { |product| product.images << image }
  end
end
