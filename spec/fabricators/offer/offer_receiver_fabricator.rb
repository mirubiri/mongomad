Fabricator(:offer_receiver, class_name: "Offer::Receiver") do
  offer             { Fabricate.build(:offer, offer_receiver:nil) }
  products(count:1) { Fabricate.build(:offer_receiver_product, receiver:nil) }
  user_id           nil
  name              nil
  image             nil

  after_build do |receiver|
    user = Fabricate.build(:user)
    receiver.user_id ||= user._id
    receiver.name ||= user.profile.name
    receiver.image ||= user.profile.image
  end
end
