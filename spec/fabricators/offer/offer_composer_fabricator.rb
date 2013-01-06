Fabricator(:offer_composer, class_name: "Offer::Composer") do
  transient :user
  offer     nil # Como es una relacion hacia arriba es nil

  products  do |a|
    # Devuelve un array de productos creados a partir de cada una
    # de las things de user
    a[:user].things.each do |thing|
      Fabricate.build(:offer_composer_product,thing:thing) #thing: es transient igual que :user
    end

  end

  user_id   { |a| a[:user]._id }
  name      { |a| a[:user].profile.name }
  image     { |a| a[:user].profile.image.url }
end