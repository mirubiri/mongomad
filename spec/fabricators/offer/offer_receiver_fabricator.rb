Fabricator(:offer_receiver, class_name: "Offer::Receiver") do
  transient :user
  offer     nil

  products  do |a|
    a[:user].things.each do |thing|
      Fabricate.build(:offer_receiver_product,thing:thing)
    end
  end

  user_id   { |a| a[:user]._id }
  name      { |a| a[:user].profile.name }
  image     { |a| a[:user].profile.image.url }
end
