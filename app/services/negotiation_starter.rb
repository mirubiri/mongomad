class NegotiationStarter
  attr_accessor :offer,:negotiation
  
  def initialize(offer)
    self.offer=offer
  end

  def start
    return negotiate_offer if offer.negotiable?
    false
  end

  private 
  def build_negotiation
    negotiation=Negotiation.new
    negotiation.proposals<<offer.proposal
    negotiation.user_sheets=offer.user_sheets
    negotiation.user_ids=offer.user_ids
    negotiation.offer_id=offer.id
    negotiation
  end

  def negotiate_offer
    negotiation=build_negotiation
    if negotiation.save
      self.negotiation=negotiation
      offer.update_attributes(negotiation_id:negotiation.id)
      negotiation
    end
  end
end