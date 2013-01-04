Fabricator(:offer_receiver, class_name: "Offer::Receiver") do
  transient         :user,:user_composer
  user_composer     { Fabricate(:user) }
  user_id           do |a|
                      a[:user] ||= Fabricate(:user)
                      a[:user]._id
                    end
  offer             { |a| Fabricate.build(:offer,receiver:nil,composer:Fabricate.build(:offer_composer, offer:nil,user:a[:user_composer])) }
  products(count:1) { |a| Fabricate.build(:offer_receiver_product,receiver:nil,thing:a[:user].things.last) }
 
  name              { |a| a[:user].profile.name }
  image             { |a| a[:user].profile.image.url }

  after_build do |receiver|
    receiver.offer.try do |offer| 
                           offer.receiver=receiver
                           User.find(receiver.user_id).received_offers << offer
                       end
  end
end
