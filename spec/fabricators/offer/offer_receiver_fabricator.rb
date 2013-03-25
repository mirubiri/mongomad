Fabricator(:offer_receiver, class_name: "Offer::Receiver") do
  transient  :user
  offer      nil
  products  do |attrs|
    products = []
    attrs[:user].things.each do |thing|
      products << Fabricate.build(:offer_receiver_product, thing:thing)
    end
    products
  end
  nickname   { |attrs| attrs[:user].profile.nickname }
  image_name { |attrs| attrs[:user].profile.image_name }
end
