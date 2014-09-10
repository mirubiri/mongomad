class NegotiableOfferPolicy
  def initialize(offer)
    @offer=offer
  end

  def negotiable?
    return false unless @offer.persisted?
    return false if @offer.negotiation_id?
    true
  end
end