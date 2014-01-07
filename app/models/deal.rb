class Deal
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :users
  embeds_many :proposals, class_name:'Proposal', as: :proposal_container
  embeds_many :messages,  class_name:'Message', as: :message_container

  validates_presence_of :users, :proposals, :messages

  def agreement
    proposals.last
  end
end
