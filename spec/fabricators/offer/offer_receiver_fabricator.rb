Fabricator(:offer_receiver, class_name: "Offer::Receiver") do
  offer             nil
  products(count:1) { Fabricate.build(:offer_receiver_product) }
  user_id           'user_id'
  name              'name'
  image             { File.open('app/assets/images/rails.png') }
end