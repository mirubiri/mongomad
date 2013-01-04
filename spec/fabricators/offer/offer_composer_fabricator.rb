Fabricator(:offer_composer, class_name: "Offer::Composer") do
  transient :user
  offer     nil

  products  nil

  user_id   { |a| a[:user]._id }
  name      { |a| a[:user].profile.name }
  image     { |a| a[:user].profile.image.url }

  after_build do |composer|
    composer_user=User.find(composer.user_id)
    composer.products << composer_user.things.each do |thing|
      Fabricate.build(:offer_composer_product,thing:thing)
    end
  end
end

