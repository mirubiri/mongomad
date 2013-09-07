class Deal
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :_users, class_name: 'User', inverse_of: :deals

  embeds_many :proposals, class_name:'Proposal', as: :proposal_container
  embeds_many :messages,  class_name:'Message', as: :message_container

  validates_presence_of :proposals, :messages

# accepts_nested_attributes_for :conversation, :agreement
end
