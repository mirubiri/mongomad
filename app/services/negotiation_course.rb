class NegotiationCourse
  attr_accessor :negotiation
  def initialize(negotiation)
    self.negotiation=negotiation
  end

  def _make_offer_negotiable
    Offer.find(negotiation.offer_id).update_attributes(negotiation_id:nil)
  end

  def _one_user_left?
    !negotiation.user_ids.empty?
  end

  def leave(user_id)
    deleted = negotiation.user_ids.delete(user_id) { false }
    _make_offer_negotiable if _one_user_left?

    return negotiation.destroy unless _one_user_left?
    deleted
  end

  def sign(user_id)
    return false unless negotiation.negotiating?
    return false unless negotiation.user_ids.include? user_id
    return false if negotiation.signer?
    return false if negotiation.cash_owner == user_id
    negotiation.signer=user_id
    true
  end
end