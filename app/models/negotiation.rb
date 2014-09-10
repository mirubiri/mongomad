class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps
  include Proposable
  include Conversation

  proposal_historic :true

  field :offer_id
  field :signer

  def _initialize_ncourse
    @ncourse ||= NegotiationCourse.new(self)
  end

  def leave(user_id)
    _initialize_ncourse
    @ncourse.leave(user_id)
  end

  def sign(user_id)
    _initialize_ncourse
    @ncourse.sign(user_id)
  end

  def cash_owner
    goods.type(Cash).first.try(:user_id)
  end

  def negotiable?
    @policy ||=NegotiableNegotiationPolicy.new(self)
    @policy.negotiable?
  end
end
