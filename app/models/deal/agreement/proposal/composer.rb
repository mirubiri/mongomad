class Deal::Agreement::Proposal::Composer
  include Mongoid::Document
  include Denormalized

  embedded_in :proposal, class_name: "Deal::Agreement::Proposal"
  embeds_many :products, class_name: "Deal::Agreement::Proposal::Composer::Product", cascade_callbacks: true

  field :nick,      type: String
  field :image_url, type: String

  accepts_nested_attributes_for :products

  denormalize :nick, :image_url, from:'user.profile'

  validates :proposal,
    :products,
    :nick,
    :image_url,
    presence: true

  def user
    User.find(self.proposal.user_composer_id)
  end
end
