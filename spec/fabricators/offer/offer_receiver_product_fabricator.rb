Fabricator(:offer_receiver_product, class_name: "Offer::Receiver::Product") do
  receiver         { Fabricate.build(:offer_receiver, product:nil)}
  secondary_images(count:1) { Fabricate.build(:offer_receiver_product_image, product:nil) }
  thing_id         'thing_id'
  name             'name'
  description      'description'
  quantity         10
  main_image       'main_image_path'
end
