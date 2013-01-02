Fabricator(:offer_composer_product_image, class_name: "Offer::Composer::Product::Image") do
  product  { Fabricate.build(:offer_receiver_product, secondary_images:nil) }
  file    'file_path'
end
