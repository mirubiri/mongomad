class Negotiation::Proposal::Composer
  include Mongoid::Document
  include Denormalized

  embedded_in :proposal, class_name: "Negotiation::Proposal"
  embeds_many :products, class_name: "Negotiation::Proposal::Composer::Product", cascade_callbacks: true

  field :nickname, type: String

  mount_uploader :image, UserImageUploader, :mount_on => :image_name

  accepts_nested_attributes_for :products

  denormalize :nickname, :image_name, from:'user.profile'

  validates :proposal,
    :products,
    :nickname,
    :image_name,
    presence: true

  def user
    User.find(self.proposal.user_composer_id)
  end
end
