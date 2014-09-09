class NegotiationCourse
  attr_accessor :negotiation
  def initialize(negotiation)
    self.negotiation=negotiation
  end

  def leave(user_id)
    !negotiation.user_ids.delete_one(user_id).nil?
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