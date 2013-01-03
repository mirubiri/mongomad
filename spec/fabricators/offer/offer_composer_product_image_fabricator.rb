Fabricator(:offer_composer_product_image, class_name: "Offer::Composer::Product::Image") do
  product  { Fabricate.build(:offer_receiver_product, images:nil) }
  file    nil

  after_build do |image|
    thing = Fabricate.build(:user_thing)
    image.file = thing.file.url

    image.file &&
    image.thing.main_image = image.thing.images.last.file.url
  end
end
