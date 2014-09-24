class DealMaker
  attr_accessor :negotiation
  
  def initialize(negotiation)
    self.negotiation=negotiation
  end

  def make_deal
    return false unless negotiation.confirmer?
    deal=Deal.new
    deal.user_ids=negotiation.user_ids
    deal.messages=negotiation.messages
    deal.proposals=negotiation.proposals
    negotiation.destroy
    deal
  end
end
