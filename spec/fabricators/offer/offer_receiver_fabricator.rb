Fabricator(:offer_receiver, class_name: "Offer::Receiver") do
  offer             { Fabricate.build(:offer, offer_receiver:nil) }
  products(count:1) { Fabricate.build(:offer_receiver_product, offer_receiver:nil) }
  user_id           'user_id'
  name              'name'
  image             'image_path'
end
