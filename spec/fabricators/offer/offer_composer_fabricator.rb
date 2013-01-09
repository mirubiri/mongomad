Fabricator(:offer_composer, class_name: "Offer::Composer") do
  transient :user
  offer     nil
  products  do |attrs|
    attrs[:user].things.each do |thing|
      Fabricate.build(:offer_composer_product, thing:thing)
    end
  end
  user_id   { |attrs| attrs[:user]._id }
  name      { |attrs| attrs[:user].profile.name }
  image     { |attrs| attrs[:user].profile.image.url }
end
