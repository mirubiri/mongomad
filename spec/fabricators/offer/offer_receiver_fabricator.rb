Fabricator(:offer_receiver, class_name: "Offer::Receiver") do
  transient :user
  offer     nil
  products  do |attrs|
    products = []
    attrs[:user].things.each do |thing|
      products << Fabricate.build(:offer_receiver_product, thing:thing)
    end
    products
  end
  user_id   { |attrs| attrs[:user]._id }
  name      { |attrs| attrs[:user].profile.name }
  image     { |attrs| attrs[:user].profile.image.url }
end
