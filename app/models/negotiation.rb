class Negotiation
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :_users

  embeds_many :proposals, class_name:'Proposal', as: :proposal_container
  embeds_many :messages,  class_name:'Message', as: :message_container
  embeds_many :user_sheets, class_name:'UserSheet', as: :sheet_container

  field :performer, type:Moped::BSON::ObjectId
  field :state

  validates_presence_of :proposals, :messages,:performer, #:state

  def cash?
    proposal.cash?
  end

  def cash_owner
    proposal.cash_owner
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
end
