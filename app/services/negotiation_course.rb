class NegotiationCourse
  attr_accessor :negotiation
  def initialize(negotiation)
    self.negotiation=negotiation
  end

  def leave(user_id)
    deleted = negotiation.user_ids.delete(user_id) { false }
    make_offer_negotiable if one_user?

    return negotiation.destroy unless one_user?
    deleted
  end

  def sign(user_id)
    return false unless negotiation.negotiable?
    return false unless negotiation.user_ids.include? user_id
    return false if negotiation.signer?
    return false if negotiation.cash_owner == user_id
    negotiation.signer=user_id
    true
  end

  private

  def make_offer_negotiable
    Offer.find(negotiation.offer_id).update_attributes(negotiation_id:nil)
  end

  def one_user?
    not negotiation.user_ids.empty?
  end
end