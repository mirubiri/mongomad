Fabricator(:offer_composer, class_name: "Offer::Composer") do
  offer             { Fabricate(:offer,composer:nil) }
  products          nil
  user_id           nil
  name              nil
  image             nil

  after_build do |composer|
    user = User.find(composer.user_id)
    composer.user_id ||= user._id
    composer.name ||= user.profile.name
    composer.image ||= user.profile.image
    composer.products || composer.products << Fabricate.build(:offer_composer_product,composer:composer)
  end
end
