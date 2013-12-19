class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :_users

  embeds_many :proposals, class_name:'Proposal', as: :proposal_container
  embeds_many :messages,  class_name:'Message', as: :message_container

  field :state

  validates_presence_of :proposals, :state

  def cash?
    proposal.cash?
  end

  def cash_owner
    proposal.goods.type(Cash).first.owner_id
  end

  def proposal
    proposals.last
  end

  def composer
    proposal.composer_id
  end

  def receiver
    proposal.receiver_id
  end

  def sign(user_id)
  end

  def confirm(user_id)
  end

  def reject(user_id)
  end
end
