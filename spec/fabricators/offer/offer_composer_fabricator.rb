Fabricator(:offer_composer, class_name: "Offer::Composer") do
  offer             nil
  products(count:1) { Fabricate.build(:offer_composer_product) }
  user_id           'user_id'
  name              'name'
  image             { File.open('app/assets/images/rails.png') }
end