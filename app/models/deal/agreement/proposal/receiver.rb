class Deal::Agreement::Proposal::Receiver
  include Mongoid::Document
  include ImageManagement::ImageHolder

  embedded_in :proposal, class_name: 'Deal::Agreement::Proposal'
  embeds_many :products, class_name: 'Deal::Agreement::Proposal::Receiver::Product', cascade_callbacks: true

  field :nick, type: String

  accepts_nested_attributes_for :products

  validates :products,
    :nick,
    presence: true
end
