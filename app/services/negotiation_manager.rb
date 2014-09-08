class NegotiationManager

  def start_negotiation(offer)
    offer.negotiable? && _make_negotiation(offer)
  end

  def _make_negotiation(offer)
    negotiation=Negotiation.new
    negotiation.proposals<<offer.proposal
    negotiation.user_sheets=offer.user_sheets
    negotiation
  end
end