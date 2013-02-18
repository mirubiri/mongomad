module MongomadHelpers
  private
	  def params_for_offerable(offerable)
	    {
	      user_composer_id: offerable.user_composer_id,
	      user_receiver_id: offerable.user_receiver_id,
	      composer_things:  offerable.composer.products.map do |product|
	        { thing_id: product[:thing_id], quantity: product[:quantity] }
	      end,
	      receiver_things:  offerable.receiver.products.map do |product|
	        { thing_id: product[:thing_id], quantity: product[:quantity] }
	      end,
	      money: { user_id: offerable.money.user_id, quantity: offerable.money.quantity }
	    }
	  end

  public
	  def params_for_offer(offer)
	    hash=params_for_offerable(offer)
	    hash[:initial_message]=offer.initial_message
	    hash
	  end

	  alias_method :params_for_proposal, :params_for_offerable
end




	  


