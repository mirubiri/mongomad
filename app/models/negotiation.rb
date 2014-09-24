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

  def authorized?(user_id)
    authorized_policy.authorized? user_id
  end

  def sign(user_id)
    negotiation_signer.sign(user_id)
  end

  def unsign(user_id)
    negotiation_signer.unsign(user_id)
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

  def can_unsign?(user_id)
    can_unsign_policy.can_unsign?(user_id)
  end

  def can_confirm?(user_id)
    can_confirm_policy.can_confirm?(user_id)
  end

  def post_message(message)
    message_poster.post_message(message)
  end

  def propose(proposal)
    negotiation_proposer.propose(proposal)
  end

  def participant?(user_id)
    user_ids.include? user_id
  end

  def reset_course
    negotiable? && update_attributes(signer:nil)
  end
  
  private

  def negotiation_proposer
    @negotiation_proposer ||= NegotiationProposer.new(self)
  end

  def message_poster
    @message_poster ||= MessagePoster.new(self)
  end

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

  def authorized_policy
    @authorized_policy ||= AuthorizedNegotiationPolicy.new(self)
  end

  def can_sign_policy
    @can_sign_policy ||= CanSignNegotiationPolicy.new(self)
  end

  def can_unsign_policy
    @can_unsign_policy ||= CanUnsignNegotiationPolicy.new(self) 
  end

  def can_confirm_policy
    @can_confirm_policy ||= CanConfirmNegotiationPolicy.new(self)
  end
end
