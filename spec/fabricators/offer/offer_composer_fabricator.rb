Fabricator(:offer_composer, class_name: "Offer::Composer") do
  transient         :user, :user_receiver
  user_receiver     { Fabricate(:user) }
  user_id           do |a|
                      a[:user] ||= Fabricate(:user)
                      a[:user]._id
                    end
  offer             { |a| Fabricate.build(:offer,composer:nil,receiver:Fabricate.build(:offer_receiver, offer:nil,user:a[:user_receiver])) }
  products(count:1) { |a| Fabricate.build(:offer_composer_product,composer:nil,thing:a[:user].things.last) }
 
  name              { |a| a[:user].profile.name }
  image             { |a| a[:user].profile.image.url }

  after_build do |composer|

    composer.offer.try do |offer| 
                           offer.composer=composer
                           User.find(composer.user_id).sent_offers << offer
                       end
  end
end
