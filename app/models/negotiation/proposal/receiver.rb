class Negotiation::Proposal::Receiver
  include Mongoid::Document
  include Denormalized
  include ImageManagement::ImageHolder

  embedded_in :proposal, class_name: 'Negotiation::Proposal'
  embeds_many :products, class_name: 'Negotiation::Proposal::Receiver::Product', cascade_callbacks: true

  field :name, type: String

  accepts_nested_attributes_for :products

  denormalize :image_fingerprint, from:'user.profile'
  denormalize :name, from:'user'

  validates :products,
    :name,
    presence: true

  def user
    proposal.user_receiver
  end
end
