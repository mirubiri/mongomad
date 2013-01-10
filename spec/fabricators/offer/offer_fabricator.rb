Fabricator(:offer) do
  composer        nil
  receiver        nil
  money           nil
  initial_message 'this is offer\'s initial message. it can\'t be too long but has to be long enought to try the interface.'

  after_build do |offer|
    user_composer = Fabricate(:user_with_things)
    offer.composer = Fabricate.build(:offer_composer, user:user_composer)
    user_composer.sent_offers << offer

  	user_receiver = Fabricate(:user_with_things)
    offer.receiver = Fabricate.build(:offer_receiver, user:user_receiver)
    user_receiver.received_offers << offer
  end
end

Fabricator(:offer_with_money, from: :offer) do
  money { Fabricate.build(:offer_money, user_id:nil) }

  after_build do |offer|
    offer.money.user_id = offer.composer._id
  end
end
