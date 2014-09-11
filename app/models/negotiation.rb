class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps
  include Proposable
  include Conversation

  proposal_historic :true

  field :offer_id
  field :signer

  def leave(user_id)
    ncourse.leave(user_id)
  end

  def sign(user_id)
    ncourse.sign(user_id)
  end

  def confirm(user_id)
    ncourse.confirm(user_id)
  end

  def cash_owner
    goods.type(Cash).first.try(:user_id)
  end

  def negotiable? 
    negotiable_policy.negotiable?
  end

  def can_sign?(user_id)
    can_sign_policy.can_sign?(user_id)
  end

  def can_confirm?(user_id)
    can_confirm_policy.can_confirm?(user_id)
  end

  
  private

  def negotiable_policy
    @negotiable_policy ||=NegotiableNegotiationPolicy.new(self)
  end

  def ncourse
    @ncourse ||= NegotiationCourse.new(self)
  end

  def can_sign_policy
    @can_sign_policy ||= CanSignNegotiationPolicy.new(self)
  end

  def can_confirm_policy
    @can_confirm_policy ||= CanConfirmNegotiationPolicy.new(self)
  end
end
