class Negotiation::Proposal::Composer
  include Mongoid::Document
  include Denormalized
  include ImageManagement::ImageHolder

  embedded_in :proposal, class_name: 'Negotiation::Proposal'
  embeds_many :products, class_name: 'Negotiation::Proposal::Composer::Product', cascade_callbacks: true

  field :nick, type: String

  accepts_nested_attributes_for :products

  denormalize :nick, :image_fingerprint, from:'user.profile'

  validates :products,
    :nick,
    presence: true

  def user
    proposal.user_composer
  end
end
