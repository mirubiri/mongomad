Fabricator(:offer_receiver, class_name: "Offer::Receiver") do
  transient :user
  offer     nil
  products  do |attrs|
    attrs[:user].things.each do |thing|
      Fabricate.build(:offer_receiver_product, thing:thing)
    end
  end
  user_id   { |attrs| attrs[:user]._id }
  name      { |attrs| attrs[:user].profile.name }
  image     { |attrs| attrs[:user].profile.image.url }
end
