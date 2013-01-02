Fabricator(:offer_composer_product, class_name: "Offer::Composer::Product") do
  composer         { Fabricate.build(:offer_composer, product:nil)}
  secondary_images(count:1) { Fabricate.build(:offer_composer_product_image, product:nil) }
  thing_id         'thing_id'
  name             'name'
  description      'description'
  quantity         10
  main_image       'main_image_path'
end
