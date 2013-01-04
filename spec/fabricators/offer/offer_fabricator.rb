Fabricator(:offer) do
  composer        nil
  receiver        nil
  money           nil
  initial_message 'a long initial message to try the interface with a long text'

  after_build do |offer|

     user_composer = Fabricate(:user)
     user_composer.sent_offers << offer
     offer.composer = Fabricate.build(:offer_composer,user:user_composer)


  	 user_receiver = Fabricate(:user)
     user_receiver.received_offers << offer
     offer.receiver = Fabricate.build(:offer_receiver,user:user_receiver)

  end
end
