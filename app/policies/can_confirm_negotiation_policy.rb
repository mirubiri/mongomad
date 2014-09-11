class CanConfirmNegotiationPolicy
  def initialize(negotiation)
    @negotiation=negotiation
  end

  def can_confirm?(user_id)
    return false unless @negotiation.negotiable?
    return false unless @negotiation.user_ids.include? user_id
    return false if @negotiation.signer == user_id
    return false unless @negotiation.signer?
    true
  end
end