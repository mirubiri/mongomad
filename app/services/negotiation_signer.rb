class NegotiationSigner

  attr_accessor :negotiation

  def initialize(negotiation)
    self.negotiation=negotiation
  end

  def sign(user_id)
    return false unless negotiation.can_sign?(user_id)
    negotiation.update_attributes(signer:user_id)
    true
  end
end