Fabricator(:offer) do
  composer        nil
  receiver        nil
  money           nil
  initial_message 'a long initial message to try the interface with a long text'

  after_build do |offer|

    user_composer = Fabricate(:user_with_things)
    offer.composer = Fabricate.build(:offer_composer,user:user_composer)
    user_composer.sent_offers << offer


  	user_receiver = Fabricate(:user_with_things)
    offer.receiver = Fabricate.build(:offer_receiver,user:user_receiver)
    user_receiver.received_offers << offer

  end
end

Fabricator(:offer_with_money, from: :offer) do
  after_build do |offer|
    offer.money=Fabricate.build(:offer_money,user_id:offer.composer.user_id)
  end
end
