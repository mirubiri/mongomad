class Deal
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :signers, class_name: 'User', inverse_of: :signers

  embeds_many :proposals, class_name:'Proposal', as: :proposal_container
  embeds_many :messages,  class_name:'Message', as: :message_container

#   accepts_nested_attributes_for :conversation, :agreement

  validates_presence_of :proposals, :messages
end
