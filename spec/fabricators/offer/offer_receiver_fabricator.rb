Fabricator(:offer_receiver, class_name: "Offer::Receiver") do
  transient :user
  offer     nil

  products  nil

  user_id   { |a| a[:user]._id }
  name      { |a| a[:user].profile.name }
  image     { |a| a[:user].profile.image.url }

  after_build do |receiver|
    receiver_user=User.find(receiver.user_id)
    receiver.products << receiver_user.things.each do |thing|
      Fabricate.build(:offer_receiver_product,thing:thing)
    end
  end
end
