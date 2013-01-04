Fabricator(:offer) do
  composer        { Fabricate.build(:offer_composer, offer:nil,user:Fabricate(:user)) }
  receiver        { Fabricate.build(:offer_receiver, offer:nil,user:Fabricate(:user)) }
  money           nil
  initial_message 'a long initial message to try the interface with a long text'

  after_build do |offer|
  	offer.composer.try do |composer| 
  						   composer.offer = offer
  						   User.find(composer.user_id).sent_offers << offer
  					   end 

  	offer.receiver.try do |receiver| 
  		                   receiver.offer = offer
  		                   User.find(receiver.user_id).received_offers << offer
  		               end
  end
end
