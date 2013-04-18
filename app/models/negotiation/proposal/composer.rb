class Negotiation::Proposal::Composer
  include Mongoid::Document
  include Denormalized

  embedded_in :proposal, class_name: 'Negotiation::Proposal'
  embeds_many :products, class_name: 'Negotiation::Proposal::Composer::Product', cascade_callbacks: true

  field :nick,      type: String
  field :image_url, type: String

  accepts_nested_attributes_for :products

  denormalize :nick, :image_url, from:'user.profile'

  validates :products,
    :nick,
    :image_url,
    presence: true

  def user
    proposal.user_composer
  end
end
