Fabricator(:offer) do
  composer        nil
  receiver        nil
  money           nil
  initial_message 'a long initial message to try the interface with a long text'

  after_build do |offer|

    user_composer = Fabricate(:user)
    offer.composer = Fabricate.build(:offer_composer,user:user_composer)
    user_composer.sent_offers << offer


  	user_receiver = Fabricate(:user)
    offer.receiver = Fabricate.build(:offer_receiver,user:user_receiver)
    user_receiver.received_offers << offer

  end
end
