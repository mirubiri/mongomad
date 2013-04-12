Fabricator(:offer_composer, class_name: "Offer::Composer") do
  transient  :user
  offer      nil
  products  do |attrs|
    products = []
    attrs[:user].things.each do |thing|
      products << Fabricate.build(:offer_composer_product, thing:thing)
    end
    products
  end
  nickname   { |attrs| attrs[:user].profile.nickname }
  image_url { |attrs| attrs[:user].profile.image_url }
end
