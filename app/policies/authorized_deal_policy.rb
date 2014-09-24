class AuthorizedDealPolicy
  attr_accessor :deal

  def initialize(deal)
    self.deal=deal
  end

  def authorized?(user_id)
    deal.participant? user_id
  end
end
