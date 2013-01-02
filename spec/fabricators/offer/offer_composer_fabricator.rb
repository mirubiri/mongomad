Fabricator(:offer_composer, class_name: "Offer::Composer") do
  offer             { Fabricate.build(:offer, offer_composer:nil) }
  products(count:1) { Fabricate.build(:offer_composer_product, offer_composer:nil) }
  user_id           'user_id'
  name              'name'
  image             'image_path'
end
