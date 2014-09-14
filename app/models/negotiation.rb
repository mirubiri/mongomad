class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps
  include Proposable
  include Conversation

  proposal_historic :true

  field :offer_id
  field :signer
  field :confirmer

  def abandon(user_id)
    negotiation_user_abandoner.abandon(user_id)
  end

  def sign(user_id)
    negotiation_signer.sign(user_id)
  end

  def confirm(user_id)
    negotiation_confirmer.confirm(user_id)
  end

  def cash_owner
    goods.type(Cash).first.try(:user_id)
  end

  def negotiable? 
    negotiable_policy.negotiable?
  end

  def abandoned?
    user_ids.count < 2
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

  def negotiation_signer
    @negotiation_signer ||= NegotiationSigner.new(self)
  end

  def negotiation_confirmer
    @negotiation_confirmer ||= NegotiationConfirmer.new(self)
  end

  def negotiation_user_abandoner
    @negotiation_abandoner ||= NegotiationUserAbandoner.new(self)
  end

  def can_sign_policy
    @can_sign_policy ||= CanSignNegotiationPolicy.new(self)
  end

  def can_confirm_policy
    @can_confirm_policy ||= CanConfirmNegotiationPolicy.new(self)
  end
end
