class CanSignNegotiationPolicy
  
  def initialize(negotiation)
    @negotiation=negotiation
  end

  def can_sign?(user_id)
    return false unless @negotiation.authorized? user_id
    return false unless @negotiation.negotiable?
    return false if @negotiation.signer?
    return false if @negotiation.cash_owner == user_id
    true
  end
end
