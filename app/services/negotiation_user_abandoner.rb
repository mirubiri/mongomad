class NegotiationUserAbandoner
  attr_accessor :negotiation

  def initialize(negotiation)
    self.negotiation=negotiation
  end

  def abandon(user_id)
    unless negotiation.abandoned?
      make_offer_negotiable
      remove_user(user_id)
    else
      negotiation.destroy
    end
  end

  private

  def remove_user(user_id)
    result= negotiation.user_ids.delete(user_id) { false } && true
    negotiation.persisted? ? negotiation.save : result
  end

  def make_offer_negotiable
    offer=Offer.where(id:negotiation.offer_id).first
    offer.update_attributes(negotiation_id:nil) unless offer.nil?
  end
end