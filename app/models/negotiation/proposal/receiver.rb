class Negotiation::Proposal::Receiver
  include Mongoid::Document
  include Denormalized

  embedded_in :proposal, class_name: "Negotiation::Proposal"
  embeds_many :products, class_name: "Negotiation::Proposal::Receiver::Product", cascade_callbacks: true

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
    @user ||= User.find(self.proposal.user_receiver_id)
  end

  def reload
    @user = nil
    super
  end
end
