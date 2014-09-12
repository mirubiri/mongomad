class NegotiableOfferPolicy
  attr_accessor :offer

  def initialize(offer)
    self.offer=offer
  end

  def negotiable?
    return false unless offer.persisted?
    return false if offer.negotiating?
    true
  end
end