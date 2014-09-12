class NegotiationConfirmer
  attr_accessor :negotiation

  def initialize(negotiation)
    self.negotiation=negotiation
  end

  def confirm(user_id)
    return false unless negotiation.can_confirm? user_id
    negotiation.update_attributes(confirmer:user_id)
    deal_maker.make_deal
  end

  private

  def deal_maker
    @deal_maker ||= DealMaker.new(negotiation)
  end

end