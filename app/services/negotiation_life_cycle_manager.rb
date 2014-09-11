class NegotiationLifeCycleManager
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
    return false unless negotiation.can_sign?(user_id)
    negotiation.signer=user_id
    true
  end

  def confirm(user_id)
    return false unless negotiation.can_confirm? user_id
    deal_maker.make_deal
  end

  private

  def make_offer_negotiable
    Offer.find(negotiation.offer_id).update_attributes(negotiation_id:nil)
  end

  def one_user?
    not negotiation.user_ids.empty?
  end

  def deal_maker
    @deal_maker ||= DealMaker.new(negotiation)
  end
end